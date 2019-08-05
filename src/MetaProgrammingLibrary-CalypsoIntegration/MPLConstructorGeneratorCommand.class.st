Class {
	#name : #MPLConstructorGeneratorCommand,
	#superclass : #MPLMethodCommand,
	#category : #'MetaProgrammingLibrary-CalypsoIntegration'
}

{ #category : #activation }
MPLConstructorGeneratorCommand class >> methodMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byItemOf: MPLMenuGroup for: ClyMethod asCalypsoItemContext 
]

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
			receiveMessage: #generate;
			yourself
]
