package arbor

import "list"

#Repository: string & =~"^[a-zA-Z0-9._-]{1,100}$"

#Arbor: {
	branches: [#Repository]: {
		parent: null | #Repository
		leaves: [...#Repository] & list.UniqueItems
	}

	let rootNames = [
		for name, branch in branches
		if branch.parent == null {
			name
		}
	]

	_exactOneRoot: len(rootNames) == 1

	_branchesPointToRoot: and([
		for _, branch in branches
		if branch.parent != null {
			branch.parent == rootNames[0]
		}
	])
}