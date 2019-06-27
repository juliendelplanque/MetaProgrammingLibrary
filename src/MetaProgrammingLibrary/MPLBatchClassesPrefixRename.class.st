Class {
	#name : #MPLBatchClassesPrefixRename,
	#superclass : #MPLAbstractGenerator,
	#instVars : [
		'oldPrefix',
		'newPrefix',
		'classes'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #default }
MPLBatchClassesPrefixRename class >> defaultNewPrefix [
	^ ''
]

{ #category : #accessing }
MPLBatchClassesPrefixRename >> classes [
	^ classes
]

{ #category : #accessing }
MPLBatchClassesPrefixRename >> classes: anObject [
	classes := anObject
]

{ #category : #generating }
MPLBatchClassesPrefixRename >> generate [
	self classes
		select: [ :c | c name beginsWith: self oldPrefix ]
		thenDo: [ :classToBeRenamed |
			(RBRenameClassRefactoring rename: classToBeRenamed to: self newPrefix , (classToBeRenamed name allButFirst: self oldPrefix size)) execute ]
]

{ #category : #initialization }
MPLBatchClassesPrefixRename >> initialize [
	super initialize.
	self
		newPrefix: self class defaultNewPrefix;
		classes: #()
]

{ #category : #accessing }
MPLBatchClassesPrefixRename >> newPrefix [
	^ newPrefix
]

{ #category : #accessing }
MPLBatchClassesPrefixRename >> newPrefix: anObject [
	newPrefix := anObject
]

{ #category : #accessing }
MPLBatchClassesPrefixRename >> oldPrefix [
	^ oldPrefix
]

{ #category : #accessing }
MPLBatchClassesPrefixRename >> oldPrefix: anObject [
	oldPrefix := anObject
]

{ #category : #accessing }
MPLBatchClassesPrefixRename >> package: aRPackage [
	self packages: { aRPackage }
]

{ #category : #accessing }
MPLBatchClassesPrefixRename >> packages: aCollectionOfRPackage [
	self classes: (aCollectionOfRPackage flatCollect: #definedClasses)
]
