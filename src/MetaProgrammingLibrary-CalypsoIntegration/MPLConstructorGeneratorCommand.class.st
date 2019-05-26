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
	
	^CmdContextMenuActivation byRootGroupItemOrder: 10000 for: ClyMethod asCalypsoItemContext 
]

{ #category : #execution }
MPLConstructorGeneratorCommand >> defaultMenuItemName [
	^'Generate constructor'
]

{ #category : #execution }
MPLConstructorGeneratorCommand >> execute [
	| code |
	code := 'DPGConstructorGenerator new
	targetClass: {1};
	mutatorSelectors: {2};
	createDummyParameterNames;
	generate' format: { self targetClass name . (self methods collect: #selector) asArray storeString }.
	Smalltalk tools workspace edit: code label: 'Code for meta-programming'
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
