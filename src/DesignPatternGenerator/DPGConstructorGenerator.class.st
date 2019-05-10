Class {
	#name : #DPGConstructorGenerator,
	#superclass : #DPGAbstractGenerator,
	#instVars : [
		'targetClass',
		'constructorArgumentNames',
		'protocol',
		'mutatorSelectors'
	],
	#category : #DesignPatternGenerator
}

{ #category : #default }
DPGConstructorGenerator class >> defaultConstructorProtocol [
	^ 'instance creation'
]

{ #category : #generating }
DPGConstructorGenerator >> buildConstructorSourceCode [
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
DPGConstructorGenerator >> constructorArgumentNames [
	^ constructorArgumentNames
]

{ #category : #accessing }
DPGConstructorGenerator >> constructorArgumentNames: anObject [
	constructorArgumentNames := anObject
]

{ #category : #configuring }
DPGConstructorGenerator >> createDummyParameterNames [
	self constructorArgumentNames: (self mutatorMethods collect: [ :method | method selector allButLast ])
]

{ #category : #generating }
DPGConstructorGenerator >> generate [
	| selector |
	selector := self targetClass classSide compile: self buildConstructorSourceCode.
	(self targetClass classSide >> selector)
		protocol: self protocol
]

{ #category : #initialization }
DPGConstructorGenerator >> initialize [
	super initialize.
	self protocol: self class defaultConstructorProtocol
]

{ #category : #accessing }
DPGConstructorGenerator >> mutatorMethods [
	^ self mutatorSelectors collect: [ :selector | self targetClass >> selector ]
]

{ #category : #accessing }
DPGConstructorGenerator >> mutatorSelectors [
	^ mutatorSelectors
]

{ #category : #accessing }
DPGConstructorGenerator >> mutatorSelectors: aCollection [
	mutatorSelectors := aCollection
]

{ #category : #accessing }
DPGConstructorGenerator >> protocol [
	^ protocol
]

{ #category : #accessing }
DPGConstructorGenerator >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
DPGConstructorGenerator >> targetClass [
	^ targetClass
]

{ #category : #accessing }
DPGConstructorGenerator >> targetClass: anObject [
	targetClass := anObject
]
