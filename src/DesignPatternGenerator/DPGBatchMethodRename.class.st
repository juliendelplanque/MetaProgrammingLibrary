Class {
	#name : #DPGBatchMethodRename,
	#superclass : #DPGAbstractGenerator,
	#instVars : [
		'oldSubstring',
		'newSubstring',
		'methods',
		'comparisonSelector'
	],
	#category : #DesignPatternGenerator
}

{ #category : #examples }
DPGBatchMethodRename class >> example [
	DPGBatchClassesPrefixRename new
		methods: {(Object >> #haltIf:) . (Object >> #haltOnCount:)};
		oldSubstring: 'halt';
		newSubstring: 'break';
		generate
]

{ #category : #examples }
DPGBatchMethodRename class >> example2 [
	DPGBatchClassesPrefixRename new
		class: Object;
		oldSubstring: 'halt';
		newSubstring: 'break';
		useBeginsWith;
		generate
]

{ #category : #accessing }
DPGBatchMethodRename >> classe: aClass [
	self methods: aClass methods
]

{ #category : #accessing }
DPGBatchMethodRename >> classes: aCollectionOfClasses [
	self methods: (aCollectionOfClasses flatCollect: #methods)
]

{ #category : #accessing }
DPGBatchMethodRename >> comparisonSelector [
	^ comparisonSelector
]

{ #category : #accessing }
DPGBatchMethodRename >> comparisonSelector: anObject [
	comparisonSelector := anObject
]

{ #category : #generating }
DPGBatchMethodRename >> generate [
	self validate.

	self methods
		select: [ :method | method selector perform: self comparisonSelector with: self oldSubstring ]
		thenDo: [ :method | 
			| permutationMap |
			"We want to keep the arguments in the same order"
			permutationMap := method numArgs = 0 ifTrue: [ #() ] ifFalse: [ (1 to: method numArgs) asArray ].

			(RBRenameMethodRefactoring
				renameMethod: method selector
				in: method class
				to: (method selector copyReplaceAll: self oldSubstring with: self newSubstring)
				permutation: permutationMap) execute ]
]

{ #category : #initialization }
DPGBatchMethodRename >> initialize [
	super initialize.
	self comparisonSelector: #includesSubstring:
]

{ #category : #accessing }
DPGBatchMethodRename >> methods [
	^ methods
]

{ #category : #accessing }
DPGBatchMethodRename >> methods: anObject [
	methods := anObject
]

{ #category : #accessing }
DPGBatchMethodRename >> newSubstring [
	^ newSubstring
]

{ #category : #accessing }
DPGBatchMethodRename >> newSubstring: anObject [
	newSubstring := anObject
]

{ #category : #accessing }
DPGBatchMethodRename >> oldSubstring [
	^ oldSubstring
]

{ #category : #accessing }
DPGBatchMethodRename >> oldSubstring: anObject [
	oldSubstring := anObject
]

{ #category : #initialization }
DPGBatchMethodRename >> useBeginsWith [
	self comparisonSelector: #beginsWith:
]

{ #category : #initialization }
DPGBatchMethodRename >> useEndsWith [
	self comparisonSelector: #endsWith:
]

{ #category : #accessing }
DPGBatchMethodRename >> validate [
	self methods isEmptyOrNil ifTrue: [ self error: 'Methods are needed to execute this action' ].
	self newSubstring ifNil: [ self error: 'A new substring is needed even if the new one should be empty.' ].
	self oldSubstring ifNil: [ self error: 'A substring to replace in methods names is needed.' ]
]
