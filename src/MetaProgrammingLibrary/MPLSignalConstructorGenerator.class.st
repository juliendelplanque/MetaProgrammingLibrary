Class {
	#name : #MPLSignalConstructorGenerator,
	#superclass : #MPLConstructorGenerator,
	#category : #MetaProgrammingLibrary
}

{ #category : #generating }
MPLSignalConstructorGenerator >> buildConstructorAST [
	| ast cascade |
	ast := super buildConstructorAST.
	ast selector: ('signalFor' , ast selector asCamelCase) asSymbol.
	cascade := ast body statements first value.
	cascade messages removeLast.
	cascade receiveMessage: #signal.
	^ ast
]
