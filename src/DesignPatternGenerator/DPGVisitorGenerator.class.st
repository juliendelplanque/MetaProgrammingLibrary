Class {
	#name : #DPGVisitorGenerator,
	#superclass : #DPGAbstractGenerator,
	#instVars : [
		'visitor',
		'visited',
		'visitedMethodProtocol',
		'visitorMethodsProtocol',
		'visitedMethodTemplate',
		'visitorMethodTemplate',
		'shouldGenerateMethodInVisitedClasses'
	],
	#category : #DesignPatternGenerator
}

{ #category : #default }
DPGVisitorGenerator class >> defaultVisitedMethodProtocol [
	^ 'visiting'
]

{ #category : #default }
DPGVisitorGenerator class >> defaultVisitedMethodTemplate [
	^ 'acceptVisitor: a{visitorClassName}
	^ a{visitorClassName} visit{visitedClassName}: self'
]

{ #category : #default }
DPGVisitorGenerator class >> defaultVisitorMethodProtocol [
	^ 'visiting'
]

{ #category : #default }
DPGVisitorGenerator class >> defaultVisitorMethodTemplate [
	^ 'visit{visitedClassName}: a{visitedClassName}
	^ self subclassResponsibility'
]

{ #category : #generating }
DPGVisitorGenerator >> generate [
	self assert: self visitorClass isClass.
	self assert: (self visitedClasses allSatisfy: #isClass).
	
	self visitedClasses do: [ :visitedClass |
		| selector |
		self shouldGenerateMethodInVisitedClasses ifTrue: [
			selector := visitedClass compile: (self visitedMethodForVisited: visitedClass).
			(visitedClass >> selector)
				protocol: self visitedMethodProtocol ].
		selector := self visitorClass compile: (self visitorMethodForVisited: visitedClass).
		(self visitorClass >> selector)
			protocol: self visitorMethodsProtocol ]
]

{ #category : #initialization }
DPGVisitorGenerator >> initialize [
	super initialize.
	self
		visitedMethodProtocol: self class defaultVisitedMethodProtocol;
		visitedMethodTemplate: self class defaultVisitedMethodTemplate;
		visitorMethodsProtocol: self class defaultVisitorMethodProtocol;
		visitorMethodTemplate: self class defaultVisitorMethodTemplate;
		shouldGenerateMethodInVisitedClasses: true
]

{ #category : #accessing }
DPGVisitorGenerator >> shouldGenerateMethodInVisitedClasses [
	^ shouldGenerateMethodInVisitedClasses
]

{ #category : #accessing }
DPGVisitorGenerator >> shouldGenerateMethodInVisitedClasses: anObject [
	shouldGenerateMethodInVisitedClasses := anObject
]

{ #category : #accessing }
DPGVisitorGenerator >> visitedClasses [
	^ visited
]

{ #category : #accessing }
DPGVisitorGenerator >> visitedClasses: anObject [
	visited := anObject
]

{ #category : #generating }
DPGVisitorGenerator >> visitedMethodForVisited: visitedClass [
	^ self visitedMethodTemplate format: { 
		'visitorClassName' -> self visitorClass name.
		'visitedClassName' -> visitedClass name } asDictionary
]

{ #category : #accessing }
DPGVisitorGenerator >> visitedMethodProtocol [
	^ visitedMethodProtocol
]

{ #category : #accessing }
DPGVisitorGenerator >> visitedMethodProtocol: anObject [
	visitedMethodProtocol := anObject
]

{ #category : #accessing }
DPGVisitorGenerator >> visitedMethodTemplate [
	^ visitedMethodTemplate
]

{ #category : #accessing }
DPGVisitorGenerator >> visitedMethodTemplate: anObject [
	visitedMethodTemplate := anObject
]

{ #category : #accessing }
DPGVisitorGenerator >> visitorClass [
	^ visitor
]

{ #category : #accessing }
DPGVisitorGenerator >> visitorClass: anObject [
	visitor := anObject
]

{ #category : #generating }
DPGVisitorGenerator >> visitorMethodForVisited: visitedClass [
	^ self visitorMethodTemplate format: { 
		'visitorClassName' -> self visitorClass name.
		'visitedClassName' -> visitedClass name } asDictionary
]

{ #category : #accessing }
DPGVisitorGenerator >> visitorMethodTemplate [
	^ visitorMethodTemplate
]

{ #category : #accessing }
DPGVisitorGenerator >> visitorMethodTemplate: anObject [
	visitorMethodTemplate := anObject
]

{ #category : #accessing }
DPGVisitorGenerator >> visitorMethodsProtocol [
	^ visitorMethodsProtocol
]

{ #category : #accessing }
DPGVisitorGenerator >> visitorMethodsProtocol: anObject [
	visitorMethodsProtocol := anObject
]
