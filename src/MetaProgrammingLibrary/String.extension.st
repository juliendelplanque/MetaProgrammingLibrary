Extension { #name : #String }

{ #category : #'*MetaProgrammingLibrary' }
String >> prefixedByAOrAn [
	^ self class streamContents: [ :stream |
		self first isVowel
			ifTrue: [ stream nextPutAll: 'an' ]
			ifFalse: [ stream nextPut: $a ].
		stream nextPutAll: self ]
]
