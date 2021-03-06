#!/usr/bin/env coffee

fs = require('fs')
uglify = require('uglify-js')
optparse = require('optparse')

array_flatten = (arr, acc) ->
    if typeof acc is 'undefined'
        acc = []
    if typeof arr is 'string'
        acc.push(arr)
        return acc

    if arr.constructor isnt Array
        throw "Value is not an Array nor a String!"

    for v in arr
        if typeof v is 'string'
            acc.push(v)
        else if v.constructor is Array
            array_flatten(v, acc)
        else
            throw "Value is not an Array nor a String!"
    return acc


minify = (data, minify_options)->
    ast = uglify.parser.parse(data)
    ast = uglify.uglify.ast_mangle(ast, minify_options)
    ast = uglify.uglify.ast_squeeze(ast)
    uglify.uglify.gen_code(ast, minify_options)

render = (filename, depth, options) ->
    tags =
        include: (args) ->
            if args.length > 1 and args[1].indexOf('c') isnt -1
                options.comment = true
            render(args[0], depth + '    ', options)
        version: ->
            options.version
        include_and_minify: (args) ->
            if args.length > 1 and args[1].indexOf('c') isnt -1
                options.comment = true
            d = render(args[0], depth + '    ', options)
            if options.minify
                return minify(array_flatten(d).join(''), options)
            return d

    console.warn(depth + " [.] Rendering", filename)

    # no trailing whitespace
    data = fs.readFileSync(filename, encoding='utf8').replace(/\s+$/, '')

    content = []
    if options.comment
        content.push('\n// ' + depth + '[*] Including ' + filename + '\n')

    elements = data.split(/<!--\s*([^>]+)\s*-->/g)
    for i in [0...elements.length]
        e = elements[i];
        if i % 2 is 0
            content.push(e)
        else
            p = e.split(' ')
            content.push( tags[p[0]](p.slice(1)) )

    if options.comment
        content.push('\n// ' + depth + '[*] End of ' + filename + '\n')
    return content


main = ->
    switches = [
        ['-p', '--pretty', 'Prettify javascript']
        ['-m', '--minify', 'Minify javascript']
        ['-s', '--set-version [VERSION]', 'Set the value of version tag']
    ]
    options = {minify: false, toplevel: true, version: 'unknown'}
    parser = new optparse.OptionParser(switches)
    parser.on 'pretty', ->
                   options.beautify = true
    parser.on 'minify', ->
                   options.minify = true
    parser.on 'set-version', (_, version) ->
                   options.version = version
    filenames = parser.parse(process.ARGV.slice(2))

    content = for filename in filenames
        render(filename, '', options)
    content.push('\n')
    process.stdout.write(array_flatten(content).join(''), 'utf8')

main()