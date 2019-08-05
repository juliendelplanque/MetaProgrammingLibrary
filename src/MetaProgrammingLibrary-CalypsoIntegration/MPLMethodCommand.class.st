Class {
	#name : #MPLMethodCommand,
	#superclass : #SycMethodCommand,
	#instVars : [
		'targetClass'
	],
	#category : #'MetaProgrammingLibrary-CalypsoIntegration'
}

{ #category : #execution }
MPLMethodCommand >> execute [
	Smalltalk tools workspace edit: self pcgAstForWorkspace sourceCode label: 'Code for meta-programming'
]

{ #category : #accessing }
MPLMethodCommand >> pcgAstForWorkspace [
	"Returns the AST for the Smalltalk code to be put in the Workspace presented to the developer."
	^ self subclassResponsibility
]

{ #category : #execution }
MPLMethodCommand >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext.
	targetClass := aToolContext selectedClasses size = 1
						ifFalse: [ aToolContext requestSingleClass: 'Choose class' from: aToolContext selectedClasses ]
						ifTrue: [ aToolContext selectedClasses anyOne ]
]

{ #category : #accessing }
MPLMethodCommand >> targetClass [
	^ targetClass
]

{ #category : #accessing }
MPLMethodCommand >> targetClass: anObject [
	targetClass := anObject
]
