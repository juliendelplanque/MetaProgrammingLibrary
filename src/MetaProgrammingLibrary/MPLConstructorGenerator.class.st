Class {
	#name : #MPLConstructorGenerator,
	#superclass : #MPLAbstractCommand,
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
MPLConstructorGenerator >> buildConstructorAST [
	^ (PCGMethodNode selectorKeywords: self mutatorSelectors arguments: (self constructorArgumentNames collect: [ :arg | arg asSymbol asPCGArgument ]))
		bodyBlock: [ :body |
			|cascade|
			cascade := (#self asPCGArgument receiveMessage: #new) asCascade.
			self mutatorSelectors with: self constructorArgumentNames do: [ :method :parameterName |
				cascade
					receiveMessage: method with: parameterName asSymbol asPCGArgument ].
			cascade
					receiveMessage: #yourself.
			body << cascade returnIt ];
		protocol: self protocol;
		yourself
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

{ #category : #executing }
MPLConstructorGenerator >> execute [
	self buildConstructorAST
		withGeneratedPragma: self withGeneratedPragma;
		installOn: self targetClass classSide
]

{ #category : #initialization }
MPLConstructorGenerator >> initialize [
	super initialize.
	self protocol: self class defaultConstructorProtocol
]

{ #category : #accessing }
MPLConstructorGenerator >> mutatorMethods [
	^ self mutatorSelectors collect: [ :selector | self targetClass lookupSelector: selector ]
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
