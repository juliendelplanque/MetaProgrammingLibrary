Class {
	#name : #BaselineOfMetaProgrammingLibrary,
	#superclass : #BaselineOf,
	#category : #BaselineOfMetaProgrammingLibrary
}

{ #category : #baselines }
BaselineOfMetaProgrammingLibrary >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec
				baseline: 'PharoCodeGenerator'
				with: [ spec repository: 'github://juliendelplanque/PharoCodeGenerator/src'].
			"Packages"
			spec
				package: 'MetaProgrammingLibrary' with: [ spec requires: #('PharoCodeGenerator') ];
				package: 'MetaProgrammingLibrary-CalypsoIntegration' with: [ spec requires: #('MetaProgrammingLibrary') ] ]
]
