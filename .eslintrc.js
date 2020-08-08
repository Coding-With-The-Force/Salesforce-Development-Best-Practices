module.exports = {
	"parser": "babel-eslint",
	"plugins": ["@lwc/eslint-plugin-lwc"],
	"env": {
		"browser": true,
		"es2020": true
	},
	"extends": "eslint:recommended",
	"parserOptions": {
		"ecmaVersion": 11,
		"sourceType": "module"
	},
	"rules": {
		"@lwc/lwc/no-deprecated": "error",
		"@lwc/lwc/valid-api": "error",
		"@lwc/lwc/no-document-query": "error",
		"indent": [
			"error",
			"tab"
		],
		"linebreak-style": [
			"error",
			"unix"
		],
		"quotes": [
			"error",
			"double"
		],
		"semi": [
			"error",
			"always"
		],
		"brace-style": [
			"error", "allman", { "allowSingleLine": false }
		],
		"curly": [
			"error", "all"
		]
	}
};
