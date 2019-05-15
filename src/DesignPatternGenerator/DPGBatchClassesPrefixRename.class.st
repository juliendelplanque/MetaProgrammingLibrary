Class {
	#name : #DPGBatchClassesPrefixRename,
	#superclass : #DPGAbstractGenerator,
	#instVars : [
		'oldPrefix',
		'newPrefix',
		'classes'
	],
	#category : #DesignPatternGenerator
}

{ #category : #default }
DPGBatchClassesPrefixRename class >> defaultNewPrefix [
	^ ''
]

{ #category : #accessing }
DPGBatchClassesPrefixRename >> classes [
	^ classes
]

{ #category : #accessing }
DPGBatchClassesPrefixRename >> classes: anObject [
	classes := anObject
]

{ #category : #generating }
DPGBatchClassesPrefixRename >> generate [
	self classes
		select: [ :c | c name beginsWith: self oldPrefix ]
		thenDo: [ :classToBeRenamed |
			classToBeRenamed rename: self newPrefix , (classToBeRenamed name allButFirst: self oldPrefix size) ]
]

{ #category : #initialization }
DPGBatchClassesPrefixRename >> initialize [
	super initialize.
	self
		newPrefix: self class defaultNewPrefix;
		classes: #()
]

{ #category : #accessing }
DPGBatchClassesPrefixRename >> newPrefix [
	^ newPrefix
]

{ #category : #accessing }
DPGBatchClassesPrefixRename >> newPrefix: anObject [
	newPrefix := anObject
]

{ #category : #accessing }
DPGBatchClassesPrefixRename >> oldPrefix [
	^ oldPrefix
]

{ #category : #accessing }
DPGBatchClassesPrefixRename >> oldPrefix: anObject [
	oldPrefix := anObject
]

{ #category : #accessing }
DPGBatchClassesPrefixRename >> packages: aCollectionOfRPackage [
	self classes: (aCollectionOfRPackage flatCollect: #definedClasses)
]
