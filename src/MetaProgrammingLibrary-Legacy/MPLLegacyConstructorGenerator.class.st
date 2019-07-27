Class {
	#name : #MPLLegacyConstructorGenerator,
	#superclass : #MPLAbstractGenerator,
	#instVars : [
		'targetClass',
		'constructorArgumentNames',
		'protocol',
		'mutatorSelectors'
	],
	#category : #'MetaProgrammingLibrary-Legacy'
}

{ #category : #default }
MPLLegacyConstructorGenerator class >> defaultConstructorProtocol [
	^ 'instance creation'
]

{ #category : #generating }
MPLLegacyConstructorGenerator >> buildConstructorSourceCode [
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
MPLLegacyConstructorGenerator >> constructorArgumentNames [
	^ constructorArgumentNames
]

{ #category : #accessing }
MPLLegacyConstructorGenerator >> constructorArgumentNames: anObject [
	constructorArgumentNames := anObject
]

{ #category : #configuring }
MPLLegacyConstructorGenerator >> createDummyParameterNames [
	self constructorArgumentNames: (self mutatorMethods collect: [ :method | method selector allButLast ])
]

{ #category : #generating }
MPLLegacyConstructorGenerator >> generate [
	| selector |
	selector := self targetClass classSide compile: self buildConstructorSourceCode.
	(self targetClass classSide >> selector)
		protocol: self protocol
]

{ #category : #initialization }
MPLLegacyConstructorGenerator >> initialize [
	super initialize.
	self protocol: self class defaultConstructorProtocol
]

{ #category : #accessing }
MPLLegacyConstructorGenerator >> mutatorMethods [
	^ self mutatorSelectors collect: [ :selector | self targetClass >> selector ]
]

{ #category : #accessing }
MPLLegacyConstructorGenerator >> mutatorSelectors [
	^ mutatorSelectors
]

{ #category : #accessing }
MPLLegacyConstructorGenerator >> mutatorSelectors: aCollection [
	mutatorSelectors := aCollection
]

{ #category : #accessing }
MPLLegacyConstructorGenerator >> protocol [
	^ protocol
]

{ #category : #accessing }
MPLLegacyConstructorGenerator >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
MPLLegacyConstructorGenerator >> targetClass [
	^ targetClass
]

{ #category : #accessing }
MPLLegacyConstructorGenerator >> targetClass: anObject [
	targetClass := anObject
]
