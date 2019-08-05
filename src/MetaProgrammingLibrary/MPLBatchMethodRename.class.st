Class {
	#name : #MPLBatchMethodRename,
	#superclass : #MPLAbstractCommand,
	#instVars : [
		'oldSubstring',
		'newSubstring',
		'methods',
		'comparisonSelector'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #examples }
MPLBatchMethodRename class >> example [
	MPLBatchMethodRename new
		methods: {(Object >> #haltIf:) . (Object >> #haltOnCount:)};
		oldSubstring: 'halt';
		newSubstring: 'break';
		execute
]

{ #category : #examples }
MPLBatchMethodRename class >> example2 [
	MPLBatchMethodRename new
		class: Object;
		oldSubstring: 'halt';
		newSubstring: 'break';
		useBeginsWith;
		execute
]

{ #category : #accessing }
MPLBatchMethodRename >> class: aClass [
	self methods: aClass methods
]

{ #category : #accessing }
MPLBatchMethodRename >> classes: aCollectionOfClasses [
	self methods: (aCollectionOfClasses flatCollect: #methods)
]

{ #category : #accessing }
MPLBatchMethodRename >> comparisonSelector [
	^ comparisonSelector
]

{ #category : #accessing }
MPLBatchMethodRename >> comparisonSelector: anObject [
	comparisonSelector := anObject
]

{ #category : #generating }
MPLBatchMethodRename >> execute [
	self validate.

	self methods
		select: [ :method | method selector perform: self comparisonSelector with: self oldSubstring ]
		thenDo: [ :method | 
			| permutationMap |
			"We want to keep the arguments in the same order"
			permutationMap := method numArgs = 0 ifTrue: [ #() ] ifFalse: [ (1 to: method numArgs) asArray ].

			(RBRenameMethodRefactoring
				renameMethod: method selector
				in: method methodClass
				to: (method selector copyReplaceAll: self oldSubstring with: self newSubstring)
				permutation: permutationMap) execute ]
]

{ #category : #initialization }
MPLBatchMethodRename >> initialize [
	super initialize.
	self comparisonSelector: #includesSubstring:
]

{ #category : #accessing }
MPLBatchMethodRename >> methods [
	^ methods
]

{ #category : #accessing }
MPLBatchMethodRename >> methods: anObject [
	methods := anObject
]

{ #category : #accessing }
MPLBatchMethodRename >> newSubstring [
	^ newSubstring
]

{ #category : #accessing }
MPLBatchMethodRename >> newSubstring: anObject [
	newSubstring := anObject
]

{ #category : #accessing }
MPLBatchMethodRename >> oldSubstring [
	^ oldSubstring
]

{ #category : #accessing }
MPLBatchMethodRename >> oldSubstring: anObject [
	oldSubstring := anObject
]

{ #category : #initialization }
MPLBatchMethodRename >> useBeginsWith [
	self comparisonSelector: #beginsWith:
]

{ #category : #initialization }
MPLBatchMethodRename >> useEndsWith [
	self comparisonSelector: #endsWith:
]

{ #category : #accessing }
MPLBatchMethodRename >> validate [
	self methods isEmptyOrNil ifTrue: [ self error: 'Methods are needed to execute this action' ].
	self newSubstring ifNil: [ self error: 'A new substring is needed even if the new one should be empty.' ].
	self oldSubstring ifNil: [ self error: 'A substring to replace in methods names is needed.' ]
]
