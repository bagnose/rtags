#include "Database.h"
#include "ReferencesJob.h"
#include "Server.h"
#include "RTags.h"
#include "CursorInfo.h"

ReferencesJob::ReferencesJob(const Location &loc, const QueryMessage &query)
    : Job(query, 0)
{
    locations.insert(loc);
}

ReferencesJob::ReferencesJob(const ByteArray &sym, const QueryMessage &query)
    : Job(query, 0), symbolName(sym)
{
}

void ReferencesJob::execute()
{
    if (!symbolName.isEmpty()) {
        ScopedDB db = Server::instance()->db(Server::SymbolName, ReadWriteLock::Read);
        locations = db->value<Set<Location> >(symbolName);
        if (locations.isEmpty()) {
            return;
        }
    }
    ScopedDB db = Server::instance()->db(Server::Symbol, ReadWriteLock::Read);
    const unsigned keyFlags = Job::keyFlags();
    const unsigned flags = queryFlags();
    for (Set<Location>::const_iterator it = locations.begin(); it != locations.end(); ++it) {
        // error() << "looking up refs for " << it->key() << bool(flags & QueryMessage::ReferencesForRenameSymbol);
        if (isAborted())
            return;

        Location pos;
        CursorInfo cursorInfo = RTags::findCursorInfo(db, *it, &pos);
        if (RTags::isReference(cursorInfo.kind)) {
            pos = cursorInfo.target;
            cursorInfo = RTags::findCursorInfo(db, cursorInfo.target);
        }
        if (queryFlags() & QueryMessage::ReferencesForRenameSymbol
            && (cursorInfo.kind == CXCursor_Constructor || cursorInfo.kind == CXCursor_Destructor)) {
            if (!cursorInfo.additionalReferences.empty()) {
                const Location &loc = *cursorInfo.additionalReferences.begin();
                const CursorInfo container = RTags::findCursorInfo(db, loc);
                if (container.isValid()) {
                    assert(container.kind == CXCursor_ClassDecl || container.kind == CXCursor_StructDecl);
                    process(db, loc, container);
                }
            }
            continue;
        }
        process(db, pos, cursorInfo);
        if (cursorInfo.target.isValid()) {
            const CursorInfo target = RTags::findCursorInfo(db, cursorInfo.target);
            if (target.kind == cursorInfo.kind)
                process(db, cursorInfo.target, target);
        }
    }

    List<Location> sorted = references.toList();
    if (flags & QueryMessage::ReverseSort) {
        std::sort(sorted.begin(), sorted.end(), std::greater<Location>());
    } else {
        std::sort(sorted.begin(), sorted.end());
    }
    for (List<Location>::const_iterator it = sorted.begin(); it != sorted.end(); ++it) {
        write(it->key(keyFlags));
    }
}

void ReferencesJob::process(ScopedDB &db, const Location &pos, const CursorInfo &cursorInfo)
{
    if (!cursorInfo.isValid())
        return;
    const bool allReferences = queryFlags() & QueryMessage::ReferencesForRenameSymbol;
    const bool renamingClass = allReferences && (cursorInfo.kind == CXCursor_StructDecl || cursorInfo.kind == CXCursor_ClassDecl);
    // error() << pos << cursorInfo << "allReferences" << allReferences;
    assert(!RTags::isReference(cursorInfo.kind));
    if (allReferences) {
        references.insert(pos);
        references += cursorInfo.references;
        if (renamingClass) {
            for (Set<Location>::const_iterator it = cursorInfo.additionalReferences.begin();
                 it != cursorInfo.additionalReferences.end(); ++it) {

                CursorInfo ci = RTags::findCursorInfo(db, *it);
                if (ci.kind == CXCursor_Destructor) {
                    references.insert(Location(it->fileId(), it->offset() + 1));
                } else {
                    references.insert(*it);
                }
            }
        }
    } else {
        references += cursorInfo.references;
        if (cursorInfo.kind == CXCursor_CXXMethod)
            references += cursorInfo.additionalReferences;
    }
}
