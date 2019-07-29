Class {
	#name : #MPLAbstractGenerator,
	#superclass : #Object,
	#instVars : [
		'withGeneratedPragma'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #generating }
MPLAbstractGenerator >> generate [
	self subclassResponsibility
]

{ #category : #initialization }
MPLAbstractGenerator >> initialize [
	super initialize.
	self withGeneratedPragma: true
]

{ #category : #accessing }
MPLAbstractGenerator >> templatesRepository [
	^ PCGTemplatesRepository new
]

{ #category : #accessing }
MPLAbstractGenerator >> withGeneratedPragma [
	^ withGeneratedPragma
]

{ #category : #accessing }
MPLAbstractGenerator >> withGeneratedPragma: anObject [
	withGeneratedPragma := anObject
]
