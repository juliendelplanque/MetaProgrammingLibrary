Class {
	#name : #DPGConstructorGeneratorCommand,
	#superclass : #SycMethodCommand,
	#instVars : [
		'targetClass'
	],
	#category : #'DesignPatternGenerator-CalypsoIntegration'
}

{ #category : #activation }
DPGConstructorGeneratorCommand class >> methodMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byRootGroupItemOrder: 10000 for: ClyMethod asCalypsoItemContext 
]

{ #category : #execution }
DPGConstructorGeneratorCommand >> defaultMenuItemName [
	^'Generate constructor'
]

{ #category : #execution }
DPGConstructorGeneratorCommand >> execute [
	| code |
	code := 'DPGConstructorGenerator new
	targetClass: {1};
	mutatorSelectors: {2};
	createDummyParameterNames;
	generate' format: { self targetClass name . (self methods collect: #selector) asArray storeString }.
	Smalltalk tools workspace edit: code label: 'Code for meta-programming'
]

{ #category : #execution }
DPGConstructorGeneratorCommand >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext.
	targetClass := aToolContext selectedClasses size = 1
						ifFalse: [ aToolContext requestSingleClass: 'Choose class' from: aToolContext selectedClasses ]
						ifTrue: [ aToolContext selectedClasses anyOne ]
]

{ #category : #accessing }
DPGConstructorGeneratorCommand >> targetClass [
	^ targetClass
]

{ #category : #accessing }
DPGConstructorGeneratorCommand >> targetClass: anObject [
	targetClass := anObject
]
