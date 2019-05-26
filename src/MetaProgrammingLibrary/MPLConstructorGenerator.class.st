Class {
	#name : #MPLConstructorGenerator,
	#superclass : #MPLAbstractGenerator,
	#instVars : [
		'targetClass',
		'constructorArgumentNames',
		'protocol',
		'mutatorSelectors'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #default }
MPLConstructorGenerator class >> defaultConstructorProtocol [
	^ 'instance creation'
]

{ #category : #generating }
MPLConstructorGenerator >> buildConstructorSourceCode [
	^ String streamContents: [ :stream |
		self mutatorMethods with: self constructorArgumentNames do: [ :method :parameterName |
			stream
				<< method selector; space; << parameterName; space ].
		stream
			cr;
			tab;
			<< '^ self new'.
		self mutatorMethods with: self constructorArgumentNames do: [ :method :parameterName |
			stream cr;
				tab; tab; << method selector; space; << parameterName; << $; ].
		stream << Character cr.
			stream << Character tab.
			stream << Character tab.
		stream << 'yourself' ]
]

{ #category : #accessing }
MPLConstructorGenerator >> constructorArgumentNames [
	^ constructorArgumentNames
]

{ #category : #accessing }
MPLConstructorGenerator >> constructorArgumentNames: anObject [
	constructorArgumentNames := anObject
]

{ #category : #configuring }
MPLConstructorGenerator >> createDummyParameterNames [
	self constructorArgumentNames: (self mutatorMethods collect: [ :method | method selector allButLast ])
]

{ #category : #generating }
MPLConstructorGenerator >> generate [
	| selector |
	selector := self targetClass classSide compile: self buildConstructorSourceCode.
	(self targetClass classSide >> selector)
		protocol: self protocol
]

{ #category : #initialization }
MPLConstructorGenerator >> initialize [
	super initialize.
	self protocol: self class defaultConstructorProtocol
]

{ #category : #accessing }
MPLConstructorGenerator >> mutatorMethods [
	^ self mutatorSelectors collect: [ :selector | self targetClass >> selector ]
]

{ #category : #accessing }
MPLConstructorGenerator >> mutatorSelectors [
	^ mutatorSelectors
]

{ #category : #accessing }
MPLConstructorGenerator >> mutatorSelectors: aCollection [
	mutatorSelectors := aCollection
]

{ #category : #accessing }
MPLConstructorGenerator >> protocol [
	^ protocol
]

{ #category : #accessing }
MPLConstructorGenerator >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
MPLConstructorGenerator >> targetClass [
	^ targetClass
]

{ #category : #accessing }
MPLConstructorGenerator >> targetClass: anObject [
	targetClass := anObject
]
