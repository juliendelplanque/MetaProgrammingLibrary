Class {
	#name : #MPLAbstractGenerator,
	#superclass : #Object,
	#category : #MetaProgrammingLibrary
}

{ #category : #generating }
MPLAbstractGenerator >> generate [
	self subclassResponsibility
]

{ #category : #accessing }
MPLAbstractGenerator >> templatesRepository [
	^ PCGTemplatesRepository new
]
