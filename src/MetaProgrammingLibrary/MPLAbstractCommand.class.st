Class {
	#name : #MPLAbstractCommand,
	#superclass : #Object,
	#instVars : [
		'withGeneratedPragma'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #generating }
MPLAbstractCommand >> execute [
	self subclassResponsibility
]

{ #category : #initialization }
MPLAbstractCommand >> initialize [
	super initialize.
	self withGeneratedPragma: true
]

{ #category : #accessing }
MPLAbstractCommand >> templatesRepository [
	^ PCGTemplatesRepository new
]

{ #category : #accessing }
MPLAbstractCommand >> withGeneratedPragma [
	^ withGeneratedPragma
]

{ #category : #accessing }
MPLAbstractCommand >> withGeneratedPragma: anObject [
	withGeneratedPragma := anObject
]
