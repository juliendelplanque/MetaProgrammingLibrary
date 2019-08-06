Class {
	#name : #MPLClassCommand,
	#superclass : #SycClassCommand,
	#instVars : [
		'targetClass'
	],
	#category : #'MetaProgrammingLibrary-CalypsoIntegration'
}

{ #category : #testing }
MPLClassCommand class >> isAbstract [
	^self = MPLClassCommand 
]

{ #category : #activation }
MPLClassCommand class >> methodMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byItemOf: MPLMenuGroup for: ClyClass asCalypsoItemContext 
]

{ #category : #execution }
MPLClassCommand >> execute [
	Smalltalk tools workspace edit: self pcgAstForWorkspace sourceCode label: 'Code for meta-programming'
]

{ #category : #accessing }
MPLClassCommand >> pcgAstForWorkspace [
	"Returns the AST for the Smalltalk code to be put in the Workspace presented to the developer."
	^ self subclassResponsibility
]

{ #category : #execution }
MPLClassCommand >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext.
	targetClass := aToolContext selectedClasses size = 1
						ifFalse: [ aToolContext requestSingleClass: 'Choose class' from: aToolContext selectedClasses ]
						ifTrue: [ aToolContext selectedClasses anyOne ]
]

{ #category : #accessing }
MPLClassCommand >> targetClass [
	^ targetClass
]

{ #category : #accessing }
MPLClassCommand >> targetClass: anObject [
	targetClass := anObject
]
