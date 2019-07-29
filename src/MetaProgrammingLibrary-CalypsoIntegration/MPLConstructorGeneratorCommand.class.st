Class {
	#name : #MPLConstructorGeneratorCommand,
	#superclass : #SycMethodCommand,
	#instVars : [
		'targetClass'
	],
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

{ #category : #execution }
MPLConstructorGeneratorCommand >> execute [
	Smalltalk tools workspace edit: self pcgAstForWorkspace sourceCode label: 'Code for meta-programming'
]

{ #category : #accessing }
MPLConstructorGeneratorCommand >> pcgAstForWorkspace [
	^ PCGSequenceNode new
		<< ((PCGCascadeNode target: (MPLConstructorGenerator asPCG receiveMessage: #new))
			receiveMessage: #targetClass: with: self targetClass asPCG;
			receiveMessage: #mutatorSelectors: with: (self methods collect: #selector) asPCG;
			receiveMessage: #createDummyParameterNames;
			receiveMessage: #withGeneratedPragma: with: true asPCG;
			receiveMessage: #generate);
	yourself
]

{ #category : #execution }
MPLConstructorGeneratorCommand >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext.
	targetClass := aToolContext selectedClasses size = 1
						ifFalse: [ aToolContext requestSingleClass: 'Choose class' from: aToolContext selectedClasses ]
						ifTrue: [ aToolContext selectedClasses anyOne ]
]

{ #category : #accessing }
MPLConstructorGeneratorCommand >> targetClass [
	^ targetClass
]

{ #category : #accessing }
MPLConstructorGeneratorCommand >> targetClass: anObject [
	targetClass := anObject
]
