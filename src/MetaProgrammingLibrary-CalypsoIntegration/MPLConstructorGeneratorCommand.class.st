Class {
	#name : #MPLConstructorGeneratorCommand,
	#superclass : #MPLMethodCommand,
	#category : #'MetaProgrammingLibrary-CalypsoIntegration'
}

{ #category : #execution }
MPLConstructorGeneratorCommand >> defaultMenuItemName [
	^'Generate constructor'
]

{ #category : #accessing }
MPLConstructorGeneratorCommand >> pcgAstForWorkspace [
	^ (PCGCascadeNode target: (MPLConstructorGenerator asPCG receiveMessage: #new))
			receiveMessage: #targetClass: with: self targetClass asPCG;
			receiveMessage: #mutatorSelectors: with: (self methods collect: #selector) asPCG;
			receiveMessage: #createDummyParameterNames;
			receiveMessage: #withGeneratedPragma: with: true asPCG;
			receiveMessage: #execute;
			yourself
]
