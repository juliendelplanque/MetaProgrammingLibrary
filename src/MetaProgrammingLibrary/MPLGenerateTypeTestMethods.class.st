Class {
	#name : #MPLGenerateTypeTestMethods,
	#superclass : #MPLAbstractGenerator,
	#instVars : [
		'targetSuperClass',
		'targetClasses'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #generating }
MPLGenerateTypeTestMethods >> generate [
	self targetClasses
		do: [ :class | 
			MPLBatchMethodGenerator new
				contextBlock: [ :c | 
					{(#selector -> ('is' , c name) asSymbol).
					(#booleanToReturn -> (class = c) asPCG)} asDictionary ];
				template: self typeTestMethodTemplate;
				targetClasses: { class. self targetSuperClass};
				generate ]
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

{ #category : #generating }
MPLGenerateTypeTestMethods >> typeTestMethodTemplate [
	^ (PCGMethodNode selector: #selector asPCGTemplateParameter)
		protocol: 'testing';
		bodyBlock: [ :body | body << #booleanToReturn returnIt ]
]
