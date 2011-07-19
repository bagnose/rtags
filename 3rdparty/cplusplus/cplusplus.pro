TEMPLATE = lib
CONFIG += static
DEFINES += CPLUSPLUS_BUILD_STATIC_LIB
DEPENDPATH += .
INCLUDEPATH += . ..

# Input
HEADERS += AST.h \
           ASTfwd.h \
           ASTMatcher.h \
           ASTParent.h \
           ASTPath.h \
           ASTPatternBuilder.h \
           ASTVisitor.h \
           BackwardsScanner.h \
           Bind.h \
           Control.h \
           CoreTypes.h \
           CPlusPlus.h \
           CPlusPlusForwardDeclarations.h \
           CppDocument.h \
           CppRewriter.h \
           DependencyTable.h \
           DeprecatedGenTemplateInstance.h \
           DiagnosticClient.h \
           ExpressionUnderCursor.h \
           FastPreprocessor.h \
           findcdbbreakpoint.h \
           FindUsages.h \
           FullySpecifiedType.h \
           Icons.h \
           Lexer.h \
           Literals.h \
           LiteralTable.h \
           LookupContext.h \
           LookupItem.h \
           Macro.h \
           MatchingText.h \
           MemoryPool.h \
           ModelManagerInterface.h \
           Name.h \
           NamePrettyPrinter.h \
           Names.h \
           NameVisitor.h \
           ObjectiveCTypeQualifiers.h \
           Overview.h \
           OverviewModel.h \
           Parser.h \
           pp-cctype.h \
           pp-engine.h \
           pp-macro-expander.h \
           pp-scanner.h \
           pp.h \
           PreprocessorClient.h \
           PreprocessorEnvironment.h \
           QtContextKeywords.h \
           ResolveExpression.h \
           Scope.h \
           SimpleLexer.h \
           SnapshotSymbolVisitor.h \
           Symbol.h \
           SymbolNameVisitor.h \
           Symbols.h \
           SymbolVisitor.h \
           Templates.h \
           Token.h \
           TranslationUnit.h \
           Type.h \
           TypeHierarchyBuilder.h \
           TypeMatcher.h \
           TypeOfExpression.h \
           TypePrettyPrinter.h \
           TypeVisitor.h \
           languageutils/componentversion.h \
           languageutils/fakemetaobject.h \
           languageutils/languageutils_global.h
SOURCES += AST.cpp \
           ASTClone.cpp \
           ASTMatch0.cpp \
           ASTMatcher.cpp \
           ASTParent.cpp \
           ASTPath.cpp \
           ASTPatternBuilder.cpp \
           ASTVisit.cpp \
           ASTVisitor.cpp \
           BackwardsScanner.cpp \
           Bind.cpp \
           Control.cpp \
           CoreTypes.cpp \
           CppDocument.cpp \
           CppRewriter.cpp \
           DependencyTable.cpp \
           DeprecatedGenTemplateInstance.cpp \
           DiagnosticClient.cpp \
           ExpressionUnderCursor.cpp \
           FastPreprocessor.cpp \
           findcdbbreakpoint.cpp \
           FindUsages.cpp \
           FullySpecifiedType.cpp \
           Icons.cpp \
           Keywords.cpp \
           Lexer.cpp \
           Literals.cpp \
           LiteralTable.cpp \
           LookupContext.cpp \
           LookupItem.cpp \
           Macro.cpp \
           MatchingText.cpp \
           MemoryPool.cpp \
           ModelManagerInterface.cpp \
           Name.cpp \
           NamePrettyPrinter.cpp \
           Names.cpp \
           NameVisitor.cpp \
           ObjectiveCAtKeywords.cpp \
           ObjectiveCTypeQualifiers.cpp \
           Overview.cpp \
           OverviewModel.cpp \
           Parser.cpp \
           pp-engine.cpp \
           pp-macro-expander.cpp \
           pp-scanner.cpp \
           PreprocessorClient.cpp \
           PreprocessorEnvironment.cpp \
           QtContextKeywords.cpp \
           ResolveExpression.cpp \
           Scope.cpp \
           SimpleLexer.cpp \
           SnapshotSymbolVisitor.cpp \
           Symbol.cpp \
           SymbolNameVisitor.cpp \
           Symbols.cpp \
           SymbolVisitor.cpp \
           Templates.cpp \
           Token.cpp \
           TranslationUnit.cpp \
           Type.cpp \
           TypeHierarchyBuilder.cpp \
           TypeMatcher.cpp \
           TypeOfExpression.cpp \
           TypePrettyPrinter.cpp \
           TypeVisitor.cpp \
           languageutils/componentversion.cpp \
           languageutils/fakemetaobject.cpp
unix {
    OBJECTS_DIR = .obj
    MOC_DIR = .moc
}
