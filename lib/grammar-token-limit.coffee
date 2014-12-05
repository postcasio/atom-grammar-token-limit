{CompositeDisposable} = require 'atom'

module.exports =
  config:
    maxTokensPerLine:
      type: 'integer'
      minimum: 1
      default: 100
      description: 'Atom limits the number of tokens that will be syntax highlighted on a line for performance reasons. Be careful when increasing this limit.'

  activate: (state) ->
    @subs = new CompositeDisposable
    @subs.add atom.grammars.onDidAddGrammar (grammar) ->
      grammar.maxTokensPerLine = atom.config.get 'grammar-token-limit.maxTokensPerLine'

    @subs.add atom.config.observe 'grammar-token-limit.maxTokensPerLine', (maxTokensPerLine) ->
      for grammar in atom.grammars.getGrammars()
          grammar.maxTokensPerLine = maxTokensPerLine

  deactivate: ->
    @subs?.dispose()

  serialize: ->
