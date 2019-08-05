Class {
	#name : #MPLTypeTestMethodsGenerator,
	#superclass : #MPLAbstractGenerator,
	#instVars : [
		'targetSuperClass',
		'targetClasses',
		'testMethodSelectorBlock'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #generating }
MPLTypeTestMethodsGenerator >> execute [
	self targetClasses
		do: [ :class | 
			MPLBatchMethodGenerator new
				contextBlock: [ :c | 
					{(#selector -> (self testMethodSelectorBlock value: class)).
					(#booleanToReturn -> (class = c) asPCG)} asDictionary ];
				template: self typeTestMethodTemplate;
				targetClasses: { class. self targetSuperClass};
				withGeneratedPragma: self withGeneratedPragma;
				execute ]
]

{ #category : #initialization }
MPLTypeTestMethodsGenerator >> initialize [
	super initialize.
	self testMethodSelectorBlock: [ :class | ('is' , class name) asSymbol ]
]

{ #category : #accessing }
MPLTypeTestMethodsGenerator >> targetClass: aClass [ 
	self targetClasses: { aClass }
]

{ #category : #accessing }
MPLTypeTestMethodsGenerator >> targetClasses [
	^ targetClasses
]

{ #category : #accessing }
MPLTypeTestMethodsGenerator >> targetClasses: anObject [
	targetClasses := anObject
]

{ #category : #accessing }
MPLTypeTestMethodsGenerator >> targetSuperClass [
	^ targetSuperClass
]

{ #category : #accessing }
MPLTypeTestMethodsGenerator >> targetSuperClass: anObject [
	targetSuperClass := anObject
]

{ #category : #accessing }
MPLTypeTestMethodsGenerator >> testMethodSelectorBlock [
	^ testMethodSelectorBlock
]

{ #category : #accessing }
MPLTypeTestMethodsGenerator >> testMethodSelectorBlock: anObject [
	testMethodSelectorBlock := anObject
]

{ #category : #generating }
MPLTypeTestMethodsGenerator >> typeTestMethodTemplate [
	^ self templatesRepository typeTestMethodTemplate
]

{ #category : #configuring }
MPLTypeTestMethodsGenerator >> withoutClassPrefixInSelector: classPrefix [
	self testMethodSelectorBlock: [ :class |
		('is' , (class name allButFirst: classPrefix size)) asSymbol ]
]
