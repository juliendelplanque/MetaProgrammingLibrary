Class {
	#name : #MPLGenerateTypeTestMethods,
	#superclass : #MPLAbstractGenerator,
	#instVars : [
		'targetSuperClass',
		'targetClasses',
		'testMethodSelectorBlock'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #generating }
MPLGenerateTypeTestMethods >> generate [
	self targetClasses
		do: [ :class | 
			MPLBatchMethodGenerator new
				contextBlock: [ :c | 
					{(#selector -> (self testMethodSelectorBlock value: class)).
					(#booleanToReturn -> (class = c) asPCG)} asDictionary ];
				template: self typeTestMethodTemplate;
				targetClasses: { class. self targetSuperClass};
				generate ]
]

{ #category : #initialization }
MPLGenerateTypeTestMethods >> initialize [
	super initialize.
	self testMethodSelectorBlock: [ :class | ('is' , class name) asSymbol ]
]

{ #category : #accessing }
MPLGenerateTypeTestMethods >> targetClasses [
	^ targetClasses
]

{ #category : #accessing }
MPLGenerateTypeTestMethods >> targetClasses: anObject [
	targetClasses := anObject
]

{ #category : #accessing }
MPLGenerateTypeTestMethods >> targetSuperClass [
	^ targetSuperClass
]

{ #category : #accessing }
MPLGenerateTypeTestMethods >> targetSuperClass: anObject [
	targetSuperClass := anObject
]

{ #category : #accessing }
MPLGenerateTypeTestMethods >> testMethodSelectorBlock [
	^ testMethodSelectorBlock
]

{ #category : #accessing }
MPLGenerateTypeTestMethods >> testMethodSelectorBlock: anObject [
	testMethodSelectorBlock := anObject
]

{ #category : #generating }
MPLGenerateTypeTestMethods >> typeTestMethodTemplate [
	^ (PCGMethodNode selector: #selector asPCGTemplateParameter)
		protocol: 'testing';
		bodyBlock: [ :body | body << #booleanToReturn asPCGTemplateParameter returnIt ]
]
