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
	| code |
	self methods size = 1 "If single method selected, directly generate."
		ifTrue: [ 
			MPLConstructorGenerator new
				targetClass: self targetClass;
				mutatorSelectors: (self methods collect: #selector);
				createDummyParameterNames;
				generate.
			^ self ].
	
	code := MPLConstructorGenerator name , ' new
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
