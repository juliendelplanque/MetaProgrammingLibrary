Class {
	#name : #MPLMenuGroup,
	#superclass : #CmdMenuGroup,
	#category : #'MetaProgrammingLibrary-CalypsoIntegration'
}

{ #category : #'as yet unclassified' }
MPLMenuGroup >> buildContextMenu: aMenu [
	aMenu addLine.
	
	super buildContextMenu: aMenu.
	
	aMenu addLine.
]

{ #category : #testing }
MPLMenuGroup >> isInlined [
	^ false
]

{ #category : #accessing }
MPLMenuGroup >> name [
	^ 'Meta Programming Library'
]

{ #category : #accessing }
MPLMenuGroup >> order [
	^ 11000
]
