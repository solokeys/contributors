# Wish we had GitHub Actions already!
#
# Usage:
#
# make show-diff handle=<handle> [variant=<variant>]
# --> help visually inspect whether CLA was modified
#
# make add-commit-handle handle=<handle>
# --> adds handle to contributors.json, commits contributors.json, and pushes

variant := individual
handle := fillme
variant_uppercase = $(shell echo $(variant) | tr '[:lower:]' '[:upper:]')

show-diff:
	diff "$(variant_uppercase)-CLA.md" $(variant)/$(handle).md

add-commit-handle:
	jq '. += ["$(handle)"]' contributors.json > updated-contributors.json
	mv updated-contributors.json contributors.json
	git add contributors.json
	git commit -m'Add $(handle) to contributors.json'
	git push
