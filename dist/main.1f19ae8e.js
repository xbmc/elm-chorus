// modules are defined as an array
// [ module function, map of requires ]
//
// map of requires is short require name -> numeric require
//
// anything defined in a previous bundle is accessed via the
// orig method which is the require for previous bundles
parcelRequire = (function (modules, cache, entry, globalName) {
  // Save the require from previous bundle to this closure if any
  var previousRequire = typeof parcelRequire === 'function' && parcelRequire;
  var nodeRequire = typeof require === 'function' && require;

  function newRequire(name, jumped) {
    if (!cache[name]) {
      if (!modules[name]) {
        // if we cannot find the module within our internal map or
        // cache jump to the current global require ie. the last bundle
        // that was added to the page.
        var currentRequire = typeof parcelRequire === 'function' && parcelRequire;
        if (!jumped && currentRequire) {
          return currentRequire(name, true);
        }

        // If there are other bundles on this page the require from the
        // previous one is saved to 'previousRequire'. Repeat this as
        // many times as there are bundles until the module is found or
        // we exhaust the require chain.
        if (previousRequire) {
          return previousRequire(name, true);
        }

        // Try the node require function if it exists.
        if (nodeRequire && typeof name === 'string') {
          return nodeRequire(name);
        }

        var err = new Error('Cannot find module \'' + name + '\'');
        err.code = 'MODULE_NOT_FOUND';
        throw err;
      }

      localRequire.resolve = resolve;
      localRequire.cache = {};

      var module = cache[name] = new newRequire.Module(name);

      modules[name][0].call(module.exports, localRequire, module, module.exports, this);
    }

    return cache[name].exports;

    function localRequire(x){
      return newRequire(localRequire.resolve(x));
    }

    function resolve(x){
      return modules[name][1][x] || x;
    }
  }

  function Module(moduleName) {
    this.id = moduleName;
    this.bundle = newRequire;
    this.exports = {};
  }

  newRequire.isParcelRequire = true;
  newRequire.Module = Module;
  newRequire.modules = modules;
  newRequire.cache = cache;
  newRequire.parent = previousRequire;
  newRequire.register = function (id, exports) {
    modules[id] = [function (require, module) {
      module.exports = exports;
    }, {}];
  };

  var error;
  for (var i = 0; i < entry.length; i++) {
    try {
      newRequire(entry[i]);
    } catch (e) {
      // Save first error but execute all entries
      if (!error) {
        error = e;
      }
    }
  }

  if (entry.length) {
    // Expose entry point to Node, AMD or browser globals
    // Based on https://github.com/ForbesLindesay/umd/blob/master/template.js
    var mainExports = newRequire(entry[entry.length - 1]);

    // CommonJS
    if (typeof exports === "object" && typeof module !== "undefined") {
      module.exports = mainExports;

    // RequireJS
    } else if (typeof define === "function" && define.amd) {
     define(function () {
       return mainExports;
     });

    // <script>
    } else if (globalName) {
      this[globalName] = mainExports;
    }
  }

  // Override the current require with this new one
  parcelRequire = newRequire;

  if (error) {
    // throw error from earlier, _after updating parcelRequire_
    throw error;
  }

  return newRequire;
})({"../src/Main.elm":[function(require,module,exports) {
(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

console.warn('Compiled in DEBUG mode. Follow the advice at https://elm-lang.org/0.19.1/optimize for better performance and smaller assets.');


var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof DataView === 'function' && value instanceof DataView)
	{
		return _Debug_stringColor(ansi, '<' + value.byteLength + ' bytes>');
	}

	if (typeof File !== 'undefined' && value instanceof File)
	{
		return _Debug_internalColor(ansi, '<' + value.name + '>');
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[36m' + string + '\x1b[0m' : string;
}

function _Debug_toHexDigit(n)
{
	return String.fromCharCode(n < 10 ? 48 + n : 55 + n);
}


// CRASH


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	/**/
	if (x.$ === 'Set_elm_builtin')
	{
		x = $elm$core$Set$toList(x);
		y = $elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	/**_UNUSED/
	if (x.$ < 0)
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (typeof x.$ === 'undefined')
	//*/
	/**/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? $elm$core$Basics$LT : n ? $elm$core$Basics$GT : $elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === $elm$core$Basics$EQ ? 0 : ord === $elm$core$Basics$LT ? -1 : 1;
	}));
});



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return !isNaN(word)
		? $elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: $elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return $elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? $elm$core$Maybe$Nothing
		: $elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return $elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? $elm$core$Maybe$Just(n) : $elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800, code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



/**/
function _Json_errorToString(error)
{
	return $elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

function _Json_decodePrim(decoder)
{
	return { $: 2, b: decoder };
}

var _Json_decodeInt = _Json_decodePrim(function(value) {
	return (typeof value !== 'number')
		? _Json_expecting('an INT', value)
		:
	(-2147483647 < value && value < 2147483647 && (value | 0) === value)
		? $elm$core$Result$Ok(value)
		:
	(isFinite(value) && !(value % 1))
		? $elm$core$Result$Ok(value)
		: _Json_expecting('an INT', value);
});

var _Json_decodeBool = _Json_decodePrim(function(value) {
	return (typeof value === 'boolean')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a BOOL', value);
});

var _Json_decodeFloat = _Json_decodePrim(function(value) {
	return (typeof value === 'number')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a FLOAT', value);
});

var _Json_decodeValue = _Json_decodePrim(function(value) {
	return $elm$core$Result$Ok(_Json_wrap(value));
});

var _Json_decodeString = _Json_decodePrim(function(value) {
	return (typeof value === 'string')
		? $elm$core$Result$Ok(value)
		: (value instanceof String)
			? $elm$core$Result$Ok(value + '')
			: _Json_expecting('a STRING', value);
});

function _Json_decodeList(decoder) { return { $: 3, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 4, b: decoder }; }

function _Json_decodeNull(value) { return { $: 5, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 6,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 7,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 8,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 9,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 10,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 11,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 2:
			return decoder.b(value);

		case 5:
			return (value === null)
				? $elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 3:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 4:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 6:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, field, result.a));

		case 7:
			var index = decoder.e;
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, index, result.a));

		case 8:
			if (typeof value !== 'object' || value === null || _Json_isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!$elm$core$Result$isOk(result))
					{
						return $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return $elm$core$Result$Ok($elm$core$List$reverse(keyValuePairs));

		case 9:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!$elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return $elm$core$Result$Ok(answer);

		case 10:
			var result = _Json_runHelp(decoder.b, value);
			return (!$elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 11:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if ($elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return $elm$core$Result$Err($elm$json$Json$Decode$OneOf($elm$core$List$reverse(errors)));

		case 1:
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return $elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!$elm$core$Result$isOk(result))
		{
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return $elm$core$Result$Ok(toElmValue(array));
}

function _Json_isArray(value)
{
	return Array.isArray(value) || (typeof FileList !== 'undefined' && value instanceof FileList);
}

function _Json_toElmArray(array)
{
	return A2($elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 2:
			return x.b === y.b;

		case 5:
			return x.c === y.c;

		case 3:
		case 4:
		case 8:
			return _Json_equality(x.b, y.b);

		case 6:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 7:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 9:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 10:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 11:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**/, _Json_errorToString(result.a) /**/);
	var managers = {};
	var initPair = init(result.a);
	var model = initPair.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		var pair = A2(update, msg, model);
		stepper(model = pair.a, viewMetadata);
		_Platform_enqueueEffects(managers, pair.b, subscriptions(model));
	}

	_Platform_enqueueEffects(managers, initPair.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS
//
// Effects must be queued!
//
// Say your init contains a synchronous command, like Time.now or Time.here
//
//   - This will produce a batch of effects (FX_1)
//   - The synchronous task triggers the subsequent `update` call
//   - This will produce a batch of effects (FX_2)
//
// If we just start dispatching FX_2, subscriptions from FX_2 can be processed
// before subscriptions from FX_1. No good! Earlier versions of this code had
// this problem, leading to these reports:
//
//   https://github.com/elm/core/issues/980
//   https://github.com/elm/core/pull/981
//   https://github.com/elm/compiler/issues/1776
//
// The queue is necessary to avoid ordering issues for synchronous commands.


// Why use true/false here? Why not just check the length of the queue?
// The goal is to detect "are we currently dispatching effects?" If we
// are, we need to bail and let the ongoing while loop handle things.
//
// Now say the queue has 1 element. When we dequeue the final element,
// the queue will be empty, but we are still actively dispatching effects.
// So you could get queue jumping in a really tricky category of cases.
//
var _Platform_effectsQueue = [];
var _Platform_effectsActive = false;


function _Platform_enqueueEffects(managers, cmdBag, subBag)
{
	_Platform_effectsQueue.push({ p: managers, q: cmdBag, r: subBag });

	if (_Platform_effectsActive) return;

	_Platform_effectsActive = true;
	for (var fx; fx = _Platform_effectsQueue.shift(); )
	{
		_Platform_dispatchEffects(fx.p, fx.q, fx.r);
	}
	_Platform_effectsActive = false;
}


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				s: bag.n,
				t: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.t)
		{
			x = temp.s(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		u: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		u: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		$elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}




// HELPERS


var _VirtualDom_divertHrefToApp;

var _VirtualDom_doc = typeof document !== 'undefined' ? document : {};


function _VirtualDom_appendChild(parent, child)
{
	parent.appendChild(child);
}

var _VirtualDom_init = F4(function(virtualNode, flagDecoder, debugMetadata, args)
{
	// NOTE: this function needs _Platform_export available to work

	/**_UNUSED/
	var node = args['node'];
	//*/
	/**/
	var node = args && args['node'] ? args['node'] : _Debug_crash(0);
	//*/

	node.parentNode.replaceChild(
		_VirtualDom_render(virtualNode, function() {}),
		node
	);

	return {};
});



// TEXT


function _VirtualDom_text(string)
{
	return {
		$: 0,
		a: string
	};
}



// NODE


var _VirtualDom_nodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 1,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_node = _VirtualDom_nodeNS(undefined);



// KEYED NODE


var _VirtualDom_keyedNodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 2,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_keyedNode = _VirtualDom_keyedNodeNS(undefined);



// CUSTOM


function _VirtualDom_custom(factList, model, render, diff)
{
	return {
		$: 3,
		d: _VirtualDom_organizeFacts(factList),
		g: model,
		h: render,
		i: diff
	};
}



// MAP


var _VirtualDom_map = F2(function(tagger, node)
{
	return {
		$: 4,
		j: tagger,
		k: node,
		b: 1 + (node.b || 0)
	};
});



// LAZY


function _VirtualDom_thunk(refs, thunk)
{
	return {
		$: 5,
		l: refs,
		m: thunk,
		k: undefined
	};
}

var _VirtualDom_lazy = F2(function(func, a)
{
	return _VirtualDom_thunk([func, a], function() {
		return func(a);
	});
});

var _VirtualDom_lazy2 = F3(function(func, a, b)
{
	return _VirtualDom_thunk([func, a, b], function() {
		return A2(func, a, b);
	});
});

var _VirtualDom_lazy3 = F4(function(func, a, b, c)
{
	return _VirtualDom_thunk([func, a, b, c], function() {
		return A3(func, a, b, c);
	});
});

var _VirtualDom_lazy4 = F5(function(func, a, b, c, d)
{
	return _VirtualDom_thunk([func, a, b, c, d], function() {
		return A4(func, a, b, c, d);
	});
});

var _VirtualDom_lazy5 = F6(function(func, a, b, c, d, e)
{
	return _VirtualDom_thunk([func, a, b, c, d, e], function() {
		return A5(func, a, b, c, d, e);
	});
});

var _VirtualDom_lazy6 = F7(function(func, a, b, c, d, e, f)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f], function() {
		return A6(func, a, b, c, d, e, f);
	});
});

var _VirtualDom_lazy7 = F8(function(func, a, b, c, d, e, f, g)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g], function() {
		return A7(func, a, b, c, d, e, f, g);
	});
});

var _VirtualDom_lazy8 = F9(function(func, a, b, c, d, e, f, g, h)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g, h], function() {
		return A8(func, a, b, c, d, e, f, g, h);
	});
});



// FACTS


var _VirtualDom_on = F2(function(key, handler)
{
	return {
		$: 'a0',
		n: key,
		o: handler
	};
});
var _VirtualDom_style = F2(function(key, value)
{
	return {
		$: 'a1',
		n: key,
		o: value
	};
});
var _VirtualDom_property = F2(function(key, value)
{
	return {
		$: 'a2',
		n: key,
		o: value
	};
});
var _VirtualDom_attribute = F2(function(key, value)
{
	return {
		$: 'a3',
		n: key,
		o: value
	};
});
var _VirtualDom_attributeNS = F3(function(namespace, key, value)
{
	return {
		$: 'a4',
		n: key,
		o: { f: namespace, o: value }
	};
});



// XSS ATTACK VECTOR CHECKS


function _VirtualDom_noScript(tag)
{
	return tag == 'script' ? 'p' : tag;
}

function _VirtualDom_noOnOrFormAction(key)
{
	return /^(on|formAction$)/i.test(key) ? 'data-' + key : key;
}

function _VirtualDom_noInnerHtmlOrFormAction(key)
{
	return key == 'innerHTML' || key == 'formAction' ? 'data-' + key : key;
}

function _VirtualDom_noJavaScriptUri_UNUSED(value)
{
	return /^javascript:/i.test(value.replace(/\s/g,'')) ? '' : value;
}

function _VirtualDom_noJavaScriptUri(value)
{
	return /^javascript:/i.test(value.replace(/\s/g,''))
		? 'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlUri_UNUSED(value)
{
	return /^\s*(javascript:|data:text\/html)/i.test(value) ? '' : value;
}

function _VirtualDom_noJavaScriptOrHtmlUri(value)
{
	return /^\s*(javascript:|data:text\/html)/i.test(value)
		? 'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'
		: value;
}



// MAP FACTS


var _VirtualDom_mapAttribute = F2(function(func, attr)
{
	return (attr.$ === 'a0')
		? A2(_VirtualDom_on, attr.n, _VirtualDom_mapHandler(func, attr.o))
		: attr;
});

function _VirtualDom_mapHandler(func, handler)
{
	var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

	// 0 = Normal
	// 1 = MayStopPropagation
	// 2 = MayPreventDefault
	// 3 = Custom

	return {
		$: handler.$,
		a:
			!tag
				? A2($elm$json$Json$Decode$map, func, handler.a)
				:
			A3($elm$json$Json$Decode$map2,
				tag < 3
					? _VirtualDom_mapEventTuple
					: _VirtualDom_mapEventRecord,
				$elm$json$Json$Decode$succeed(func),
				handler.a
			)
	};
}

var _VirtualDom_mapEventTuple = F2(function(func, tuple)
{
	return _Utils_Tuple2(func(tuple.a), tuple.b);
});

var _VirtualDom_mapEventRecord = F2(function(func, record)
{
	return {
		message: func(record.message),
		stopPropagation: record.stopPropagation,
		preventDefault: record.preventDefault
	}
});



// ORGANIZE FACTS


function _VirtualDom_organizeFacts(factList)
{
	for (var facts = {}; factList.b; factList = factList.b) // WHILE_CONS
	{
		var entry = factList.a;

		var tag = entry.$;
		var key = entry.n;
		var value = entry.o;

		if (tag === 'a2')
		{
			(key === 'className')
				? _VirtualDom_addClass(facts, key, _Json_unwrap(value))
				: facts[key] = _Json_unwrap(value);

			continue;
		}

		var subFacts = facts[tag] || (facts[tag] = {});
		(tag === 'a3' && key === 'class')
			? _VirtualDom_addClass(subFacts, key, value)
			: subFacts[key] = value;
	}

	return facts;
}

function _VirtualDom_addClass(object, key, newClass)
{
	var classes = object[key];
	object[key] = classes ? classes + ' ' + newClass : newClass;
}



// RENDER


function _VirtualDom_render(vNode, eventNode)
{
	var tag = vNode.$;

	if (tag === 5)
	{
		return _VirtualDom_render(vNode.k || (vNode.k = vNode.m()), eventNode);
	}

	if (tag === 0)
	{
		return _VirtualDom_doc.createTextNode(vNode.a);
	}

	if (tag === 4)
	{
		var subNode = vNode.k;
		var tagger = vNode.j;

		while (subNode.$ === 4)
		{
			typeof tagger !== 'object'
				? tagger = [tagger, subNode.j]
				: tagger.push(subNode.j);

			subNode = subNode.k;
		}

		var subEventRoot = { j: tagger, p: eventNode };
		var domNode = _VirtualDom_render(subNode, subEventRoot);
		domNode.elm_event_node_ref = subEventRoot;
		return domNode;
	}

	if (tag === 3)
	{
		var domNode = vNode.h(vNode.g);
		_VirtualDom_applyFacts(domNode, eventNode, vNode.d);
		return domNode;
	}

	// at this point `tag` must be 1 or 2

	var domNode = vNode.f
		? _VirtualDom_doc.createElementNS(vNode.f, vNode.c)
		: _VirtualDom_doc.createElement(vNode.c);

	if (_VirtualDom_divertHrefToApp && vNode.c == 'a')
	{
		domNode.addEventListener('click', _VirtualDom_divertHrefToApp(domNode));
	}

	_VirtualDom_applyFacts(domNode, eventNode, vNode.d);

	for (var kids = vNode.e, i = 0; i < kids.length; i++)
	{
		_VirtualDom_appendChild(domNode, _VirtualDom_render(tag === 1 ? kids[i] : kids[i].b, eventNode));
	}

	return domNode;
}



// APPLY FACTS


function _VirtualDom_applyFacts(domNode, eventNode, facts)
{
	for (var key in facts)
	{
		var value = facts[key];

		key === 'a1'
			? _VirtualDom_applyStyles(domNode, value)
			:
		key === 'a0'
			? _VirtualDom_applyEvents(domNode, eventNode, value)
			:
		key === 'a3'
			? _VirtualDom_applyAttrs(domNode, value)
			:
		key === 'a4'
			? _VirtualDom_applyAttrsNS(domNode, value)
			:
		((key !== 'value' && key !== 'checked') || domNode[key] !== value) && (domNode[key] = value);
	}
}



// APPLY STYLES


function _VirtualDom_applyStyles(domNode, styles)
{
	var domNodeStyle = domNode.style;

	for (var key in styles)
	{
		domNodeStyle[key] = styles[key];
	}
}



// APPLY ATTRS


function _VirtualDom_applyAttrs(domNode, attrs)
{
	for (var key in attrs)
	{
		var value = attrs[key];
		typeof value !== 'undefined'
			? domNode.setAttribute(key, value)
			: domNode.removeAttribute(key);
	}
}



// APPLY NAMESPACED ATTRS


function _VirtualDom_applyAttrsNS(domNode, nsAttrs)
{
	for (var key in nsAttrs)
	{
		var pair = nsAttrs[key];
		var namespace = pair.f;
		var value = pair.o;

		typeof value !== 'undefined'
			? domNode.setAttributeNS(namespace, key, value)
			: domNode.removeAttributeNS(namespace, key);
	}
}



// APPLY EVENTS


function _VirtualDom_applyEvents(domNode, eventNode, events)
{
	var allCallbacks = domNode.elmFs || (domNode.elmFs = {});

	for (var key in events)
	{
		var newHandler = events[key];
		var oldCallback = allCallbacks[key];

		if (!newHandler)
		{
			domNode.removeEventListener(key, oldCallback);
			allCallbacks[key] = undefined;
			continue;
		}

		if (oldCallback)
		{
			var oldHandler = oldCallback.q;
			if (oldHandler.$ === newHandler.$)
			{
				oldCallback.q = newHandler;
				continue;
			}
			domNode.removeEventListener(key, oldCallback);
		}

		oldCallback = _VirtualDom_makeCallback(eventNode, newHandler);
		domNode.addEventListener(key, oldCallback,
			_VirtualDom_passiveSupported
			&& { passive: $elm$virtual_dom$VirtualDom$toHandlerInt(newHandler) < 2 }
		);
		allCallbacks[key] = oldCallback;
	}
}



// PASSIVE EVENTS


var _VirtualDom_passiveSupported;

try
{
	window.addEventListener('t', null, Object.defineProperty({}, 'passive', {
		get: function() { _VirtualDom_passiveSupported = true; }
	}));
}
catch(e) {}



// EVENT HANDLERS


function _VirtualDom_makeCallback(eventNode, initialHandler)
{
	function callback(event)
	{
		var handler = callback.q;
		var result = _Json_runHelp(handler.a, event);

		if (!$elm$core$Result$isOk(result))
		{
			return;
		}

		var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

		// 0 = Normal
		// 1 = MayStopPropagation
		// 2 = MayPreventDefault
		// 3 = Custom

		var value = result.a;
		var message = !tag ? value : tag < 3 ? value.a : value.message;
		var stopPropagation = tag == 1 ? value.b : tag == 3 && value.stopPropagation;
		var currentEventNode = (
			stopPropagation && event.stopPropagation(),
			(tag == 2 ? value.b : tag == 3 && value.preventDefault) && event.preventDefault(),
			eventNode
		);
		var tagger;
		var i;
		while (tagger = currentEventNode.j)
		{
			if (typeof tagger == 'function')
			{
				message = tagger(message);
			}
			else
			{
				for (var i = tagger.length; i--; )
				{
					message = tagger[i](message);
				}
			}
			currentEventNode = currentEventNode.p;
		}
		currentEventNode(message, stopPropagation); // stopPropagation implies isSync
	}

	callback.q = initialHandler;

	return callback;
}

function _VirtualDom_equalEvents(x, y)
{
	return x.$ == y.$ && _Json_equality(x.a, y.a);
}



// DIFF


// TODO: Should we do patches like in iOS?
//
// type Patch
//   = At Int Patch
//   | Batch (List Patch)
//   | Change ...
//
// How could it not be better?
//
function _VirtualDom_diff(x, y)
{
	var patches = [];
	_VirtualDom_diffHelp(x, y, patches, 0);
	return patches;
}


function _VirtualDom_pushPatch(patches, type, index, data)
{
	var patch = {
		$: type,
		r: index,
		s: data,
		t: undefined,
		u: undefined
	};
	patches.push(patch);
	return patch;
}


function _VirtualDom_diffHelp(x, y, patches, index)
{
	if (x === y)
	{
		return;
	}

	var xType = x.$;
	var yType = y.$;

	// Bail if you run into different types of nodes. Implies that the
	// structure has changed significantly and it's not worth a diff.
	if (xType !== yType)
	{
		if (xType === 1 && yType === 2)
		{
			y = _VirtualDom_dekey(y);
			yType = 1;
		}
		else
		{
			_VirtualDom_pushPatch(patches, 0, index, y);
			return;
		}
	}

	// Now we know that both nodes are the same $.
	switch (yType)
	{
		case 5:
			var xRefs = x.l;
			var yRefs = y.l;
			var i = xRefs.length;
			var same = i === yRefs.length;
			while (same && i--)
			{
				same = xRefs[i] === yRefs[i];
			}
			if (same)
			{
				y.k = x.k;
				return;
			}
			y.k = y.m();
			var subPatches = [];
			_VirtualDom_diffHelp(x.k, y.k, subPatches, 0);
			subPatches.length > 0 && _VirtualDom_pushPatch(patches, 1, index, subPatches);
			return;

		case 4:
			// gather nested taggers
			var xTaggers = x.j;
			var yTaggers = y.j;
			var nesting = false;

			var xSubNode = x.k;
			while (xSubNode.$ === 4)
			{
				nesting = true;

				typeof xTaggers !== 'object'
					? xTaggers = [xTaggers, xSubNode.j]
					: xTaggers.push(xSubNode.j);

				xSubNode = xSubNode.k;
			}

			var ySubNode = y.k;
			while (ySubNode.$ === 4)
			{
				nesting = true;

				typeof yTaggers !== 'object'
					? yTaggers = [yTaggers, ySubNode.j]
					: yTaggers.push(ySubNode.j);

				ySubNode = ySubNode.k;
			}

			// Just bail if different numbers of taggers. This implies the
			// structure of the virtual DOM has changed.
			if (nesting && xTaggers.length !== yTaggers.length)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			// check if taggers are "the same"
			if (nesting ? !_VirtualDom_pairwiseRefEqual(xTaggers, yTaggers) : xTaggers !== yTaggers)
			{
				_VirtualDom_pushPatch(patches, 2, index, yTaggers);
			}

			// diff everything below the taggers
			_VirtualDom_diffHelp(xSubNode, ySubNode, patches, index + 1);
			return;

		case 0:
			if (x.a !== y.a)
			{
				_VirtualDom_pushPatch(patches, 3, index, y.a);
			}
			return;

		case 1:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKids);
			return;

		case 2:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKeyedKids);
			return;

		case 3:
			if (x.h !== y.h)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
			factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

			var patch = y.i(x.g, y.g);
			patch && _VirtualDom_pushPatch(patches, 5, index, patch);

			return;
	}
}

// assumes the incoming arrays are the same length
function _VirtualDom_pairwiseRefEqual(as, bs)
{
	for (var i = 0; i < as.length; i++)
	{
		if (as[i] !== bs[i])
		{
			return false;
		}
	}

	return true;
}

function _VirtualDom_diffNodes(x, y, patches, index, diffKids)
{
	// Bail if obvious indicators have changed. Implies more serious
	// structural changes such that it's not worth it to diff.
	if (x.c !== y.c || x.f !== y.f)
	{
		_VirtualDom_pushPatch(patches, 0, index, y);
		return;
	}

	var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
	factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

	diffKids(x, y, patches, index);
}



// DIFF FACTS


// TODO Instead of creating a new diff object, it's possible to just test if
// there *is* a diff. During the actual patch, do the diff again and make the
// modifications directly. This way, there's no new allocations. Worth it?
function _VirtualDom_diffFacts(x, y, category)
{
	var diff;

	// look for changes and removals
	for (var xKey in x)
	{
		if (xKey === 'a1' || xKey === 'a0' || xKey === 'a3' || xKey === 'a4')
		{
			var subDiff = _VirtualDom_diffFacts(x[xKey], y[xKey] || {}, xKey);
			if (subDiff)
			{
				diff = diff || {};
				diff[xKey] = subDiff;
			}
			continue;
		}

		// remove if not in the new facts
		if (!(xKey in y))
		{
			diff = diff || {};
			diff[xKey] =
				!category
					? (typeof x[xKey] === 'string' ? '' : null)
					:
				(category === 'a1')
					? ''
					:
				(category === 'a0' || category === 'a3')
					? undefined
					:
				{ f: x[xKey].f, o: undefined };

			continue;
		}

		var xValue = x[xKey];
		var yValue = y[xKey];

		// reference equal, so don't worry about it
		if (xValue === yValue && xKey !== 'value' && xKey !== 'checked'
			|| category === 'a0' && _VirtualDom_equalEvents(xValue, yValue))
		{
			continue;
		}

		diff = diff || {};
		diff[xKey] = yValue;
	}

	// add new stuff
	for (var yKey in y)
	{
		if (!(yKey in x))
		{
			diff = diff || {};
			diff[yKey] = y[yKey];
		}
	}

	return diff;
}



// DIFF KIDS


function _VirtualDom_diffKids(xParent, yParent, patches, index)
{
	var xKids = xParent.e;
	var yKids = yParent.e;

	var xLen = xKids.length;
	var yLen = yKids.length;

	// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

	if (xLen > yLen)
	{
		_VirtualDom_pushPatch(patches, 6, index, {
			v: yLen,
			i: xLen - yLen
		});
	}
	else if (xLen < yLen)
	{
		_VirtualDom_pushPatch(patches, 7, index, {
			v: xLen,
			e: yKids
		});
	}

	// PAIRWISE DIFF EVERYTHING ELSE

	for (var minLen = xLen < yLen ? xLen : yLen, i = 0; i < minLen; i++)
	{
		var xKid = xKids[i];
		_VirtualDom_diffHelp(xKid, yKids[i], patches, ++index);
		index += xKid.b || 0;
	}
}



// KEYED DIFF


function _VirtualDom_diffKeyedKids(xParent, yParent, patches, rootIndex)
{
	var localPatches = [];

	var changes = {}; // Dict String Entry
	var inserts = []; // Array { index : Int, entry : Entry }
	// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

	var xKids = xParent.e;
	var yKids = yParent.e;
	var xLen = xKids.length;
	var yLen = yKids.length;
	var xIndex = 0;
	var yIndex = 0;

	var index = rootIndex;

	while (xIndex < xLen && yIndex < yLen)
	{
		var x = xKids[xIndex];
		var y = yKids[yIndex];

		var xKey = x.a;
		var yKey = y.a;
		var xNode = x.b;
		var yNode = y.b;

		var newMatch = undefined;
		var oldMatch = undefined;

		// check if keys match

		if (xKey === yKey)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNode, localPatches, index);
			index += xNode.b || 0;

			xIndex++;
			yIndex++;
			continue;
		}

		// look ahead 1 to detect insertions and removals.

		var xNext = xKids[xIndex + 1];
		var yNext = yKids[yIndex + 1];

		if (xNext)
		{
			var xNextKey = xNext.a;
			var xNextNode = xNext.b;
			oldMatch = yKey === xNextKey;
		}

		if (yNext)
		{
			var yNextKey = yNext.a;
			var yNextNode = yNext.b;
			newMatch = xKey === yNextKey;
		}


		// swap x and y
		if (newMatch && oldMatch)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			_VirtualDom_insertNode(changes, localPatches, xKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNextNode, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		// insert y
		if (newMatch)
		{
			index++;
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			index += xNode.b || 0;

			xIndex += 1;
			yIndex += 2;
			continue;
		}

		// remove x
		if (oldMatch)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 1;
			continue;
		}

		// remove x, insert y
		if (xNext && xNextKey === yNextKey)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNextNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		break;
	}

	// eat up any remaining nodes with removeNode and insertNode

	while (xIndex < xLen)
	{
		index++;
		var x = xKids[xIndex];
		var xNode = x.b;
		_VirtualDom_removeNode(changes, localPatches, x.a, xNode, index);
		index += xNode.b || 0;
		xIndex++;
	}

	while (yIndex < yLen)
	{
		var endInserts = endInserts || [];
		var y = yKids[yIndex];
		_VirtualDom_insertNode(changes, localPatches, y.a, y.b, undefined, endInserts);
		yIndex++;
	}

	if (localPatches.length > 0 || inserts.length > 0 || endInserts)
	{
		_VirtualDom_pushPatch(patches, 8, rootIndex, {
			w: localPatches,
			x: inserts,
			y: endInserts
		});
	}
}



// CHANGES FROM KEYED DIFF


var _VirtualDom_POSTFIX = '_elmW6BL';


function _VirtualDom_insertNode(changes, localPatches, key, vnode, yIndex, inserts)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		entry = {
			c: 0,
			z: vnode,
			r: yIndex,
			s: undefined
		};

		inserts.push({ r: yIndex, A: entry });
		changes[key] = entry;

		return;
	}

	// this key was removed earlier, a match!
	if (entry.c === 1)
	{
		inserts.push({ r: yIndex, A: entry });

		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(entry.z, vnode, subPatches, entry.r);
		entry.r = yIndex;
		entry.s.s = {
			w: subPatches,
			A: entry
		};

		return;
	}

	// this key has already been inserted or moved, a duplicate!
	_VirtualDom_insertNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, yIndex, inserts);
}


function _VirtualDom_removeNode(changes, localPatches, key, vnode, index)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		var patch = _VirtualDom_pushPatch(localPatches, 9, index, undefined);

		changes[key] = {
			c: 1,
			z: vnode,
			r: index,
			s: patch
		};

		return;
	}

	// this key was inserted earlier, a match!
	if (entry.c === 0)
	{
		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(vnode, entry.z, subPatches, index);

		_VirtualDom_pushPatch(localPatches, 9, index, {
			w: subPatches,
			A: entry
		});

		return;
	}

	// this key has already been removed or moved, a duplicate!
	_VirtualDom_removeNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, index);
}



// ADD DOM NODES
//
// Each DOM node has an "index" assigned in order of traversal. It is important
// to minimize our crawl over the actual DOM, so these indexes (along with the
// descendantsCount of virtual nodes) let us skip touching entire subtrees of
// the DOM if we know there are no patches there.


function _VirtualDom_addDomNodes(domNode, vNode, patches, eventNode)
{
	_VirtualDom_addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.b, eventNode);
}


// assumes `patches` is non-empty and indexes increase monotonically.
function _VirtualDom_addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
{
	var patch = patches[i];
	var index = patch.r;

	while (index === low)
	{
		var patchType = patch.$;

		if (patchType === 1)
		{
			_VirtualDom_addDomNodes(domNode, vNode.k, patch.s, eventNode);
		}
		else if (patchType === 8)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var subPatches = patch.s.w;
			if (subPatches.length > 0)
			{
				_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
			}
		}
		else if (patchType === 9)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var data = patch.s;
			if (data)
			{
				data.A.s = domNode;
				var subPatches = data.w;
				if (subPatches.length > 0)
				{
					_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
		}
		else
		{
			patch.t = domNode;
			patch.u = eventNode;
		}

		i++;

		if (!(patch = patches[i]) || (index = patch.r) > high)
		{
			return i;
		}
	}

	var tag = vNode.$;

	if (tag === 4)
	{
		var subNode = vNode.k;

		while (subNode.$ === 4)
		{
			subNode = subNode.k;
		}

		return _VirtualDom_addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);
	}

	// tag must be 1 or 2 at this point

	var vKids = vNode.e;
	var childNodes = domNode.childNodes;
	for (var j = 0; j < vKids.length; j++)
	{
		low++;
		var vKid = tag === 1 ? vKids[j] : vKids[j].b;
		var nextLow = low + (vKid.b || 0);
		if (low <= index && index <= nextLow)
		{
			i = _VirtualDom_addDomNodesHelp(childNodes[j], vKid, patches, i, low, nextLow, eventNode);
			if (!(patch = patches[i]) || (index = patch.r) > high)
			{
				return i;
			}
		}
		low = nextLow;
	}
	return i;
}



// APPLY PATCHES


function _VirtualDom_applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
{
	if (patches.length === 0)
	{
		return rootDomNode;
	}

	_VirtualDom_addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
	return _VirtualDom_applyPatchesHelp(rootDomNode, patches);
}

function _VirtualDom_applyPatchesHelp(rootDomNode, patches)
{
	for (var i = 0; i < patches.length; i++)
	{
		var patch = patches[i];
		var localDomNode = patch.t
		var newNode = _VirtualDom_applyPatch(localDomNode, patch);
		if (localDomNode === rootDomNode)
		{
			rootDomNode = newNode;
		}
	}
	return rootDomNode;
}

function _VirtualDom_applyPatch(domNode, patch)
{
	switch (patch.$)
	{
		case 0:
			return _VirtualDom_applyPatchRedraw(domNode, patch.s, patch.u);

		case 4:
			_VirtualDom_applyFacts(domNode, patch.u, patch.s);
			return domNode;

		case 3:
			domNode.replaceData(0, domNode.length, patch.s);
			return domNode;

		case 1:
			return _VirtualDom_applyPatchesHelp(domNode, patch.s);

		case 2:
			if (domNode.elm_event_node_ref)
			{
				domNode.elm_event_node_ref.j = patch.s;
			}
			else
			{
				domNode.elm_event_node_ref = { j: patch.s, p: patch.u };
			}
			return domNode;

		case 6:
			var data = patch.s;
			for (var i = 0; i < data.i; i++)
			{
				domNode.removeChild(domNode.childNodes[data.v]);
			}
			return domNode;

		case 7:
			var data = patch.s;
			var kids = data.e;
			var i = data.v;
			var theEnd = domNode.childNodes[i];
			for (; i < kids.length; i++)
			{
				domNode.insertBefore(_VirtualDom_render(kids[i], patch.u), theEnd);
			}
			return domNode;

		case 9:
			var data = patch.s;
			if (!data)
			{
				domNode.parentNode.removeChild(domNode);
				return domNode;
			}
			var entry = data.A;
			if (typeof entry.r !== 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
			}
			entry.s = _VirtualDom_applyPatchesHelp(domNode, data.w);
			return domNode;

		case 8:
			return _VirtualDom_applyPatchReorder(domNode, patch);

		case 5:
			return patch.s(domNode);

		default:
			_Debug_crash(10); // 'Ran into an unknown patch!'
	}
}


function _VirtualDom_applyPatchRedraw(domNode, vNode, eventNode)
{
	var parentNode = domNode.parentNode;
	var newNode = _VirtualDom_render(vNode, eventNode);

	if (!newNode.elm_event_node_ref)
	{
		newNode.elm_event_node_ref = domNode.elm_event_node_ref;
	}

	if (parentNode && newNode !== domNode)
	{
		parentNode.replaceChild(newNode, domNode);
	}
	return newNode;
}


function _VirtualDom_applyPatchReorder(domNode, patch)
{
	var data = patch.s;

	// remove end inserts
	var frag = _VirtualDom_applyPatchReorderEndInsertsHelp(data.y, patch);

	// removals
	domNode = _VirtualDom_applyPatchesHelp(domNode, data.w);

	// inserts
	var inserts = data.x;
	for (var i = 0; i < inserts.length; i++)
	{
		var insert = inserts[i];
		var entry = insert.A;
		var node = entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u);
		domNode.insertBefore(node, domNode.childNodes[insert.r]);
	}

	// add end inserts
	if (frag)
	{
		_VirtualDom_appendChild(domNode, frag);
	}

	return domNode;
}


function _VirtualDom_applyPatchReorderEndInsertsHelp(endInserts, patch)
{
	if (!endInserts)
	{
		return;
	}

	var frag = _VirtualDom_doc.createDocumentFragment();
	for (var i = 0; i < endInserts.length; i++)
	{
		var insert = endInserts[i];
		var entry = insert.A;
		_VirtualDom_appendChild(frag, entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u)
		);
	}
	return frag;
}


function _VirtualDom_virtualize(node)
{
	// TEXT NODES

	if (node.nodeType === 3)
	{
		return _VirtualDom_text(node.textContent);
	}


	// WEIRD NODES

	if (node.nodeType !== 1)
	{
		return _VirtualDom_text('');
	}


	// ELEMENT NODES

	var attrList = _List_Nil;
	var attrs = node.attributes;
	for (var i = attrs.length; i--; )
	{
		var attr = attrs[i];
		var name = attr.name;
		var value = attr.value;
		attrList = _List_Cons( A2(_VirtualDom_attribute, name, value), attrList );
	}

	var tag = node.tagName.toLowerCase();
	var kidList = _List_Nil;
	var kids = node.childNodes;

	for (var i = kids.length; i--; )
	{
		kidList = _List_Cons(_VirtualDom_virtualize(kids[i]), kidList);
	}
	return A3(_VirtualDom_node, tag, attrList, kidList);
}

function _VirtualDom_dekey(keyedNode)
{
	var keyedKids = keyedNode.e;
	var len = keyedKids.length;
	var kids = new Array(len);
	for (var i = 0; i < len; i++)
	{
		kids[i] = keyedKids[i].b;
	}

	return {
		$: 1,
		c: keyedNode.c,
		d: keyedNode.d,
		e: kids,
		f: keyedNode.f,
		b: keyedNode.b
	};
}



var _Bitwise_and = F2(function(a, b)
{
	return a & b;
});

var _Bitwise_or = F2(function(a, b)
{
	return a | b;
});

var _Bitwise_xor = F2(function(a, b)
{
	return a ^ b;
});

function _Bitwise_complement(a)
{
	return ~a;
};

var _Bitwise_shiftLeftBy = F2(function(offset, a)
{
	return a << offset;
});

var _Bitwise_shiftRightBy = F2(function(offset, a)
{
	return a >> offset;
});

var _Bitwise_shiftRightZfBy = F2(function(offset, a)
{
	return a >>> offset;
});




// HELPERS


function _Debugger_unsafeCoerce(value)
{
	return value;
}



// PROGRAMS


var _Debugger_element = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		A3($elm$browser$Debugger$Main$wrapInit, _Json_wrap(debugMetadata), _Debugger_popout(), impl.init),
		$elm$browser$Debugger$Main$wrapUpdate(impl.update),
		$elm$browser$Debugger$Main$wrapSubs(impl.subscriptions),
		function(sendToApp, initialModel)
		{
			var view = impl.view;
			var title = _VirtualDom_doc.title;
			var domNode = args && args['node'] ? args['node'] : _Debug_crash(0);
			var currNode = _VirtualDom_virtualize(domNode);
			var currBlocker = $elm$browser$Debugger$Main$toBlockerType(initialModel);
			var currPopout;

			var cornerNode = _VirtualDom_doc.createElement('div');
			domNode.parentNode.insertBefore(cornerNode, domNode.nextSibling);
			var cornerCurr = _VirtualDom_virtualize(cornerNode);

			initialModel.popout.a = sendToApp;

			return _Browser_makeAnimator(initialModel, function(model)
			{
				var nextNode = A2(_VirtualDom_map, $elm$browser$Debugger$Main$UserMsg, view($elm$browser$Debugger$Main$getUserModel(model)));
				var patches = _VirtualDom_diff(currNode, nextNode);
				domNode = _VirtualDom_applyPatches(domNode, currNode, patches, sendToApp);
				currNode = nextNode;

				// update blocker

				var nextBlocker = $elm$browser$Debugger$Main$toBlockerType(model);
				_Debugger_updateBlocker(currBlocker, nextBlocker);
				currBlocker = nextBlocker;

				// view corner

				var cornerNext = $elm$browser$Debugger$Main$cornerView(model);
				var cornerPatches = _VirtualDom_diff(cornerCurr, cornerNext);
				cornerNode = _VirtualDom_applyPatches(cornerNode, cornerCurr, cornerPatches, sendToApp);
				cornerCurr = cornerNext;

				if (!model.popout.b)
				{
					currPopout = undefined;
					return;
				}

				// view popout

				_VirtualDom_doc = model.popout.b; // SWITCH TO POPOUT DOC
				currPopout || (currPopout = _VirtualDom_virtualize(model.popout.b));
				var nextPopout = $elm$browser$Debugger$Main$popoutView(model);
				var popoutPatches = _VirtualDom_diff(currPopout, nextPopout);
				_VirtualDom_applyPatches(model.popout.b.body, currPopout, popoutPatches, sendToApp);
				currPopout = nextPopout;
				_VirtualDom_doc = document; // SWITCH BACK TO NORMAL DOC
			});
		}
	);
});


var _Debugger_document = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		A3($elm$browser$Debugger$Main$wrapInit, _Json_wrap(debugMetadata), _Debugger_popout(), impl.init),
		$elm$browser$Debugger$Main$wrapUpdate(impl.update),
		$elm$browser$Debugger$Main$wrapSubs(impl.subscriptions),
		function(sendToApp, initialModel)
		{
			var divertHrefToApp = impl.setup && impl.setup(function(x) { return sendToApp($elm$browser$Debugger$Main$UserMsg(x)); });
			var view = impl.view;
			var title = _VirtualDom_doc.title;
			var bodyNode = _VirtualDom_doc.body;
			var currNode = _VirtualDom_virtualize(bodyNode);
			var currBlocker = $elm$browser$Debugger$Main$toBlockerType(initialModel);
			var currPopout;

			initialModel.popout.a = sendToApp;

			return _Browser_makeAnimator(initialModel, function(model)
			{
				_VirtualDom_divertHrefToApp = divertHrefToApp;
				var doc = view($elm$browser$Debugger$Main$getUserModel(model));
				var nextNode = _VirtualDom_node('body')(_List_Nil)(
					_Utils_ap(
						A2($elm$core$List$map, _VirtualDom_map($elm$browser$Debugger$Main$UserMsg), doc.body),
						_List_Cons($elm$browser$Debugger$Main$cornerView(model), _List_Nil)
					)
				);
				var patches = _VirtualDom_diff(currNode, nextNode);
				bodyNode = _VirtualDom_applyPatches(bodyNode, currNode, patches, sendToApp);
				currNode = nextNode;
				_VirtualDom_divertHrefToApp = 0;
				(title !== doc.title) && (_VirtualDom_doc.title = title = doc.title);

				// update blocker

				var nextBlocker = $elm$browser$Debugger$Main$toBlockerType(model);
				_Debugger_updateBlocker(currBlocker, nextBlocker);
				currBlocker = nextBlocker;

				// view popout

				if (!model.popout.b) { currPopout = undefined; return; }

				_VirtualDom_doc = model.popout.b; // SWITCH TO POPOUT DOC
				currPopout || (currPopout = _VirtualDom_virtualize(model.popout.b));
				var nextPopout = $elm$browser$Debugger$Main$popoutView(model);
				var popoutPatches = _VirtualDom_diff(currPopout, nextPopout);
				_VirtualDom_applyPatches(model.popout.b.body, currPopout, popoutPatches, sendToApp);
				currPopout = nextPopout;
				_VirtualDom_doc = document; // SWITCH BACK TO NORMAL DOC
			});
		}
	);
});


function _Debugger_popout()
{
	return {
		b: undefined,
		a: undefined
	};
}

function _Debugger_isOpen(popout)
{
	return !!popout.b;
}

function _Debugger_open(popout)
{
	return _Scheduler_binding(function(callback)
	{
		_Debugger_openWindow(popout);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}

function _Debugger_openWindow(popout)
{
	var w = $elm$browser$Debugger$Main$initialWindowWidth,
		h = $elm$browser$Debugger$Main$initialWindowHeight,
	 	x = screen.width - w,
		y = screen.height - h;

	var debuggerWindow = window.open('', '', 'width=' + w + ',height=' + h + ',left=' + x + ',top=' + y);
	var doc = debuggerWindow.document;
	doc.title = 'Elm Debugger';

	// handle arrow keys
	doc.addEventListener('keydown', function(event) {
		event.metaKey && event.which === 82 && window.location.reload();
		event.key === 'ArrowUp'   && (popout.a($elm$browser$Debugger$Main$Up  ), event.preventDefault());
		event.key === 'ArrowDown' && (popout.a($elm$browser$Debugger$Main$Down), event.preventDefault());
	});

	// handle window close
	window.addEventListener('unload', close);
	debuggerWindow.addEventListener('unload', function() {
		popout.b = undefined;
		popout.a($elm$browser$Debugger$Main$NoOp);
		window.removeEventListener('unload', close);
	});

	function close() {
		popout.b = undefined;
		popout.a($elm$browser$Debugger$Main$NoOp);
		debuggerWindow.close();
	}

	// register new window
	popout.b = doc;
}



// SCROLL


function _Debugger_scroll(popout)
{
	return _Scheduler_binding(function(callback)
	{
		if (popout.b)
		{
			var msgs = popout.b.getElementById('elm-debugger-sidebar');
			if (msgs && msgs.scrollTop !== 0)
			{
				msgs.scrollTop = 0;
			}
		}
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


var _Debugger_scrollTo = F2(function(id, popout)
{
	return _Scheduler_binding(function(callback)
	{
		if (popout.b)
		{
			var msg = popout.b.getElementById(id);
			if (msg)
			{
				msg.scrollIntoView(false);
			}
		}
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});



// UPLOAD


function _Debugger_upload(popout)
{
	return _Scheduler_binding(function(callback)
	{
		var doc = popout.b || document;
		var element = doc.createElement('input');
		element.setAttribute('type', 'file');
		element.setAttribute('accept', 'text/json');
		element.style.display = 'none';
		element.addEventListener('change', function(event)
		{
			var fileReader = new FileReader();
			fileReader.onload = function(e)
			{
				callback(_Scheduler_succeed(e.target.result));
			};
			fileReader.readAsText(event.target.files[0]);
			doc.body.removeChild(element);
		});
		doc.body.appendChild(element);
		element.click();
	});
}



// DOWNLOAD


var _Debugger_download = F2(function(historyLength, json)
{
	return _Scheduler_binding(function(callback)
	{
		var fileName = 'history-' + historyLength + '.txt';
		var jsonString = JSON.stringify(json);
		var mime = 'text/plain;charset=utf-8';
		var done = _Scheduler_succeed(_Utils_Tuple0);

		// for IE10+
		if (navigator.msSaveBlob)
		{
			navigator.msSaveBlob(new Blob([jsonString], {type: mime}), fileName);
			return callback(done);
		}

		// for HTML5
		var element = document.createElement('a');
		element.setAttribute('href', 'data:' + mime + ',' + encodeURIComponent(jsonString));
		element.setAttribute('download', fileName);
		element.style.display = 'none';
		document.body.appendChild(element);
		element.click();
		document.body.removeChild(element);
		callback(done);
	});
});



// POPOUT CONTENT


function _Debugger_messageToString(value)
{
	if (typeof value === 'boolean')
	{
		return value ? 'True' : 'False';
	}

	if (typeof value === 'number')
	{
		return value + '';
	}

	if (typeof value === 'string')
	{
		return '"' + _Debugger_addSlashes(value, false) + '"';
	}

	if (value instanceof String)
	{
		return "'" + _Debugger_addSlashes(value, true) + "'";
	}

	if (typeof value !== 'object' || value === null || !('$' in value))
	{
		return '…';
	}

	if (typeof value.$ === 'number')
	{
		return '…';
	}

	var code = value.$.charCodeAt(0);
	if (code === 0x23 /* # */ || /* a */ 0x61 <= code && code <= 0x7A /* z */)
	{
		return '…';
	}

	if (['Array_elm_builtin', 'Set_elm_builtin', 'RBNode_elm_builtin', 'RBEmpty_elm_builtin'].indexOf(value.$) >= 0)
	{
		return '…';
	}

	var keys = Object.keys(value);
	switch (keys.length)
	{
		case 1:
			return value.$;
		case 2:
			return value.$ + ' ' + _Debugger_messageToString(value.a);
		default:
			return value.$ + ' … ' + _Debugger_messageToString(value[keys[keys.length - 1]]);
	}
}


function _Debugger_init(value)
{
	if (typeof value === 'boolean')
	{
		return A3($elm$browser$Debugger$Expando$Constructor, $elm$core$Maybe$Just(value ? 'True' : 'False'), true, _List_Nil);
	}

	if (typeof value === 'number')
	{
		return $elm$browser$Debugger$Expando$Primitive(value + '');
	}

	if (typeof value === 'string')
	{
		return $elm$browser$Debugger$Expando$S('"' + _Debugger_addSlashes(value, false) + '"');
	}

	if (value instanceof String)
	{
		return $elm$browser$Debugger$Expando$S("'" + _Debugger_addSlashes(value, true) + "'");
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (tag === '::' || tag === '[]')
		{
			return A3($elm$browser$Debugger$Expando$Sequence, $elm$browser$Debugger$Expando$ListSeq, true,
				A2($elm$core$List$map, _Debugger_init, value)
			);
		}

		if (tag === 'Set_elm_builtin')
		{
			return A3($elm$browser$Debugger$Expando$Sequence, $elm$browser$Debugger$Expando$SetSeq, true,
				A3($elm$core$Set$foldr, _Debugger_initCons, _List_Nil, value)
			);
		}

		if (tag === 'RBNode_elm_builtin' || tag == 'RBEmpty_elm_builtin')
		{
			return A2($elm$browser$Debugger$Expando$Dictionary, true,
				A3($elm$core$Dict$foldr, _Debugger_initKeyValueCons, _List_Nil, value)
			);
		}

		if (tag === 'Array_elm_builtin')
		{
			return A3($elm$browser$Debugger$Expando$Sequence, $elm$browser$Debugger$Expando$ArraySeq, true,
				A3($elm$core$Array$foldr, _Debugger_initCons, _List_Nil, value)
			);
		}

		if (typeof tag === 'number')
		{
			return $elm$browser$Debugger$Expando$Primitive('<internals>');
		}

		var char = tag.charCodeAt(0);
		if (char === 35 || 65 <= char && char <= 90)
		{
			var list = _List_Nil;
			for (var i in value)
			{
				if (i === '$') continue;
				list = _List_Cons(_Debugger_init(value[i]), list);
			}
			return A3($elm$browser$Debugger$Expando$Constructor, char === 35 ? $elm$core$Maybe$Nothing : $elm$core$Maybe$Just(tag), true, $elm$core$List$reverse(list));
		}

		return $elm$browser$Debugger$Expando$Primitive('<internals>');
	}

	if (typeof value === 'object')
	{
		var dict = $elm$core$Dict$empty;
		for (var i in value)
		{
			dict = A3($elm$core$Dict$insert, i, _Debugger_init(value[i]), dict);
		}
		return A2($elm$browser$Debugger$Expando$Record, true, dict);
	}

	return $elm$browser$Debugger$Expando$Primitive('<internals>');
}

var _Debugger_initCons = F2(function initConsHelp(value, list)
{
	return _List_Cons(_Debugger_init(value), list);
});

var _Debugger_initKeyValueCons = F3(function(key, value, list)
{
	return _List_Cons(
		_Utils_Tuple2(_Debugger_init(key), _Debugger_init(value)),
		list
	);
});

function _Debugger_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');
	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}



// BLOCK EVENTS


function _Debugger_updateBlocker(oldBlocker, newBlocker)
{
	if (oldBlocker === newBlocker) return;

	var oldEvents = _Debugger_blockerToEvents(oldBlocker);
	var newEvents = _Debugger_blockerToEvents(newBlocker);

	// remove old blockers
	for (var i = 0; i < oldEvents.length; i++)
	{
		document.removeEventListener(oldEvents[i], _Debugger_blocker, true);
	}

	// add new blockers
	for (var i = 0; i < newEvents.length; i++)
	{
		document.addEventListener(newEvents[i], _Debugger_blocker, true);
	}
}


function _Debugger_blocker(event)
{
	if (event.type === 'keydown' && event.metaKey && event.which === 82)
	{
		return;
	}

	var isScroll = event.type === 'scroll' || event.type === 'wheel';
	for (var node = event.target; node; node = node.parentNode)
	{
		if (isScroll ? node.id === 'elm-debugger-details' : node.id === 'elm-debugger-overlay')
		{
			return;
		}
	}

	event.stopPropagation();
	event.preventDefault();
}

function _Debugger_blockerToEvents(blocker)
{
	return blocker === $elm$browser$Debugger$Overlay$BlockNone
		? []
		: blocker === $elm$browser$Debugger$Overlay$BlockMost
			? _Debugger_mostEvents
			: _Debugger_allEvents;
}

var _Debugger_mostEvents = [
	'click', 'dblclick', 'mousemove',
	'mouseup', 'mousedown', 'mouseenter', 'mouseleave',
	'touchstart', 'touchend', 'touchcancel', 'touchmove',
	'pointerdown', 'pointerup', 'pointerover', 'pointerout',
	'pointerenter', 'pointerleave', 'pointermove', 'pointercancel',
	'dragstart', 'drag', 'dragend', 'dragenter', 'dragover', 'dragleave', 'drop',
	'keyup', 'keydown', 'keypress',
	'input', 'change',
	'focus', 'blur'
];

var _Debugger_allEvents = _Debugger_mostEvents.concat('wheel', 'scroll');




// ELEMENT


var _Debugger_element;

var _Browser_element = _Debugger_element || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var view = impl.view;
			/**_UNUSED/
			var domNode = args['node'];
			//*/
			/**/
			var domNode = args && args['node'] ? args['node'] : _Debug_crash(0);
			//*/
			var currNode = _VirtualDom_virtualize(domNode);

			return _Browser_makeAnimator(initialModel, function(model)
			{
				var nextNode = view(model);
				var patches = _VirtualDom_diff(currNode, nextNode);
				domNode = _VirtualDom_applyPatches(domNode, currNode, patches, sendToApp);
				currNode = nextNode;
			});
		}
	);
});



// DOCUMENT


var _Debugger_document;

var _Browser_document = _Debugger_document || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var divertHrefToApp = impl.setup && impl.setup(sendToApp)
			var view = impl.view;
			var title = _VirtualDom_doc.title;
			var bodyNode = _VirtualDom_doc.body;
			var currNode = _VirtualDom_virtualize(bodyNode);
			return _Browser_makeAnimator(initialModel, function(model)
			{
				_VirtualDom_divertHrefToApp = divertHrefToApp;
				var doc = view(model);
				var nextNode = _VirtualDom_node('body')(_List_Nil)(doc.body);
				var patches = _VirtualDom_diff(currNode, nextNode);
				bodyNode = _VirtualDom_applyPatches(bodyNode, currNode, patches, sendToApp);
				currNode = nextNode;
				_VirtualDom_divertHrefToApp = 0;
				(title !== doc.title) && (_VirtualDom_doc.title = title = doc.title);
			});
		}
	);
});



// ANIMATION


var _Browser_cancelAnimationFrame =
	typeof cancelAnimationFrame !== 'undefined'
		? cancelAnimationFrame
		: function(id) { clearTimeout(id); };

var _Browser_requestAnimationFrame =
	typeof requestAnimationFrame !== 'undefined'
		? requestAnimationFrame
		: function(callback) { return setTimeout(callback, 1000 / 60); };


function _Browser_makeAnimator(model, draw)
{
	draw(model);

	var state = 0;

	function updateIfNeeded()
	{
		state = state === 1
			? 0
			: ( _Browser_requestAnimationFrame(updateIfNeeded), draw(model), 1 );
	}

	return function(nextModel, isSync)
	{
		model = nextModel;

		isSync
			? ( draw(model),
				state === 2 && (state = 1)
				)
			: ( state === 0 && _Browser_requestAnimationFrame(updateIfNeeded),
				state = 2
				);
	};
}



// APPLICATION


function _Browser_application(impl)
{
	var onUrlChange = impl.onUrlChange;
	var onUrlRequest = impl.onUrlRequest;
	var key = function() { key.a(onUrlChange(_Browser_getUrl())); };
key['elm-hot-nav-key'] = true

	return _Browser_document({
		setup: function(sendToApp)
		{
			key.a = sendToApp;
			_Browser_window.addEventListener('popstate', key);
			_Browser_window.navigator.userAgent.indexOf('Trident') < 0 || _Browser_window.addEventListener('hashchange', key);

			return F2(function(domNode, event)
			{
				if (!event.ctrlKey && !event.metaKey && !event.shiftKey && event.button < 1 && !domNode.target && !domNode.hasAttribute('download'))
				{
					event.preventDefault();
					var href = domNode.href;
					var curr = _Browser_getUrl();
					var next = $elm$url$Url$fromString(href).a;
					sendToApp(onUrlRequest(
						(next
							&& curr.protocol === next.protocol
							&& curr.host === next.host
							&& curr.port_.a === next.port_.a
						)
							? $elm$browser$Browser$Internal(next)
							: $elm$browser$Browser$External(href)
					));
				}
			});
		},
		init: function(flags)
		{
			return A3(impl.init, flags, _Browser_getUrl(), key);
		},
		view: impl.view,
		update: impl.update,
		subscriptions: impl.subscriptions
	});
}

function _Browser_getUrl()
{
	return $elm$url$Url$fromString(_VirtualDom_doc.location.href).a || _Debug_crash(1);
}

var _Browser_go = F2(function(key, n)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		n && history.go(n);
		key();
	}));
});

var _Browser_pushUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.pushState({}, '', url);
		key();
	}));
});

var _Browser_replaceUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.replaceState({}, '', url);
		key();
	}));
});



// GLOBAL EVENTS


var _Browser_fakeNode = { addEventListener: function() {}, removeEventListener: function() {} };
var _Browser_doc = typeof document !== 'undefined' ? document : _Browser_fakeNode;
var _Browser_window = typeof window !== 'undefined' ? window : _Browser_fakeNode;

var _Browser_on = F3(function(node, eventName, sendToSelf)
{
	return _Scheduler_spawn(_Scheduler_binding(function(callback)
	{
		function handler(event)	{ _Scheduler_rawSpawn(sendToSelf(event)); }
		node.addEventListener(eventName, handler, _VirtualDom_passiveSupported && { passive: true });
		return function() { node.removeEventListener(eventName, handler); };
	}));
});

var _Browser_decodeEvent = F2(function(decoder, event)
{
	var result = _Json_runHelp(decoder, event);
	return $elm$core$Result$isOk(result) ? $elm$core$Maybe$Just(result.a) : $elm$core$Maybe$Nothing;
});



// PAGE VISIBILITY


function _Browser_visibilityInfo()
{
	return (typeof _VirtualDom_doc.hidden !== 'undefined')
		? { hidden: 'hidden', change: 'visibilitychange' }
		:
	(typeof _VirtualDom_doc.mozHidden !== 'undefined')
		? { hidden: 'mozHidden', change: 'mozvisibilitychange' }
		:
	(typeof _VirtualDom_doc.msHidden !== 'undefined')
		? { hidden: 'msHidden', change: 'msvisibilitychange' }
		:
	(typeof _VirtualDom_doc.webkitHidden !== 'undefined')
		? { hidden: 'webkitHidden', change: 'webkitvisibilitychange' }
		: { hidden: 'hidden', change: 'visibilitychange' };
}



// ANIMATION FRAMES


function _Browser_rAF()
{
	return _Scheduler_binding(function(callback)
	{
		var id = _Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(Date.now()));
		});

		return function() {
			_Browser_cancelAnimationFrame(id);
		};
	});
}


function _Browser_now()
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(Date.now()));
	});
}



// DOM STUFF


function _Browser_withNode(id, doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			var node = document.getElementById(id);
			callback(node
				? _Scheduler_succeed(doStuff(node))
				: _Scheduler_fail($elm$browser$Browser$Dom$NotFound(id))
			);
		});
	});
}


function _Browser_withWindow(doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(doStuff()));
		});
	});
}


// FOCUS and BLUR


var _Browser_call = F2(function(functionName, id)
{
	return _Browser_withNode(id, function(node) {
		node[functionName]();
		return _Utils_Tuple0;
	});
});



// WINDOW VIEWPORT


function _Browser_getViewport()
{
	return {
		scene: _Browser_getScene(),
		viewport: {
			x: _Browser_window.pageXOffset,
			y: _Browser_window.pageYOffset,
			width: _Browser_doc.documentElement.clientWidth,
			height: _Browser_doc.documentElement.clientHeight
		}
	};
}

function _Browser_getScene()
{
	var body = _Browser_doc.body;
	var elem = _Browser_doc.documentElement;
	return {
		width: Math.max(body.scrollWidth, body.offsetWidth, elem.scrollWidth, elem.offsetWidth, elem.clientWidth),
		height: Math.max(body.scrollHeight, body.offsetHeight, elem.scrollHeight, elem.offsetHeight, elem.clientHeight)
	};
}

var _Browser_setViewport = F2(function(x, y)
{
	return _Browser_withWindow(function()
	{
		_Browser_window.scroll(x, y);
		return _Utils_Tuple0;
	});
});



// ELEMENT VIEWPORT


function _Browser_getViewportOf(id)
{
	return _Browser_withNode(id, function(node)
	{
		return {
			scene: {
				width: node.scrollWidth,
				height: node.scrollHeight
			},
			viewport: {
				x: node.scrollLeft,
				y: node.scrollTop,
				width: node.clientWidth,
				height: node.clientHeight
			}
		};
	});
}


var _Browser_setViewportOf = F3(function(id, x, y)
{
	return _Browser_withNode(id, function(node)
	{
		node.scrollLeft = x;
		node.scrollTop = y;
		return _Utils_Tuple0;
	});
});



// ELEMENT


function _Browser_getElement(id)
{
	return _Browser_withNode(id, function(node)
	{
		var rect = node.getBoundingClientRect();
		var x = _Browser_window.pageXOffset;
		var y = _Browser_window.pageYOffset;
		return {
			scene: _Browser_getScene(),
			viewport: {
				x: x,
				y: y,
				width: _Browser_doc.documentElement.clientWidth,
				height: _Browser_doc.documentElement.clientHeight
			},
			element: {
				x: x + rect.left,
				y: y + rect.top,
				width: rect.width,
				height: rect.height
			}
		};
	});
}



// LOAD and RELOAD


function _Browser_reload(skipCache)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		_VirtualDom_doc.location.reload(skipCache);
	}));
}

function _Browser_load(url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		try
		{
			_Browser_window.location = url;
		}
		catch(err)
		{
			// Only Firefox can throw a NS_ERROR_MALFORMED_URI exception here.
			// Other browsers reload the page, so let's be consistent about that.
			_VirtualDom_doc.location.reload(false);
		}
	}));
}


function _Url_percentEncode(string)
{
	return encodeURIComponent(string);
}

function _Url_percentDecode(string)
{
	try
	{
		return $elm$core$Maybe$Just(decodeURIComponent(string));
	}
	catch (e)
	{
		return $elm$core$Maybe$Nothing;
	}
}


// SEND REQUEST

var _Http_toTask = F3(function(router, toTask, request)
{
	return _Scheduler_binding(function(callback)
	{
		function done(response) {
			callback(toTask(request.expect.a(response)));
		}

		var xhr = new XMLHttpRequest();
		xhr.addEventListener('error', function() { done($elm$http$Http$NetworkError_); });
		xhr.addEventListener('timeout', function() { done($elm$http$Http$Timeout_); });
		xhr.addEventListener('load', function() { done(_Http_toResponse(request.expect.b, xhr)); });
		$elm$core$Maybe$isJust(request.tracker) && _Http_track(router, xhr, request.tracker.a);

		try {
			xhr.open(request.method, request.url, true);
		} catch (e) {
			return done($elm$http$Http$BadUrl_(request.url));
		}

		_Http_configureRequest(xhr, request);

		request.body.a && xhr.setRequestHeader('Content-Type', request.body.a);
		xhr.send(request.body.b);

		return function() { xhr.c = true; xhr.abort(); };
	});
});


// CONFIGURE

function _Http_configureRequest(xhr, request)
{
	for (var headers = request.headers; headers.b; headers = headers.b) // WHILE_CONS
	{
		xhr.setRequestHeader(headers.a.a, headers.a.b);
	}
	xhr.timeout = request.timeout.a || 0;
	xhr.responseType = request.expect.d;
	xhr.withCredentials = request.allowCookiesFromOtherDomains;
}


// RESPONSES

function _Http_toResponse(toBody, xhr)
{
	return A2(
		200 <= xhr.status && xhr.status < 300 ? $elm$http$Http$GoodStatus_ : $elm$http$Http$BadStatus_,
		_Http_toMetadata(xhr),
		toBody(xhr.response)
	);
}


// METADATA

function _Http_toMetadata(xhr)
{
	return {
		url: xhr.responseURL,
		statusCode: xhr.status,
		statusText: xhr.statusText,
		headers: _Http_parseHeaders(xhr.getAllResponseHeaders())
	};
}


// HEADERS

function _Http_parseHeaders(rawHeaders)
{
	if (!rawHeaders)
	{
		return $elm$core$Dict$empty;
	}

	var headers = $elm$core$Dict$empty;
	var headerPairs = rawHeaders.split('\r\n');
	for (var i = headerPairs.length; i--; )
	{
		var headerPair = headerPairs[i];
		var index = headerPair.indexOf(': ');
		if (index > 0)
		{
			var key = headerPair.substring(0, index);
			var value = headerPair.substring(index + 2);

			headers = A3($elm$core$Dict$update, key, function(oldValue) {
				return $elm$core$Maybe$Just($elm$core$Maybe$isJust(oldValue)
					? value + ', ' + oldValue.a
					: value
				);
			}, headers);
		}
	}
	return headers;
}


// EXPECT

var _Http_expect = F3(function(type, toBody, toValue)
{
	return {
		$: 0,
		d: type,
		b: toBody,
		a: toValue
	};
});

var _Http_mapExpect = F2(function(func, expect)
{
	return {
		$: 0,
		d: expect.d,
		b: expect.b,
		a: function(x) { return func(expect.a(x)); }
	};
});

function _Http_toDataView(arrayBuffer)
{
	return new DataView(arrayBuffer);
}


// BODY and PARTS

var _Http_emptyBody = { $: 0 };
var _Http_pair = F2(function(a, b) { return { $: 0, a: a, b: b }; });

function _Http_toFormData(parts)
{
	for (var formData = new FormData(); parts.b; parts = parts.b) // WHILE_CONS
	{
		var part = parts.a;
		formData.append(part.a, part.b);
	}
	return formData;
}

var _Http_bytesToBlob = F2(function(mime, bytes)
{
	return new Blob([bytes], { type: mime });
});


// PROGRESS

function _Http_track(router, xhr, tracker)
{
	// TODO check out lengthComputable on loadstart event

	xhr.upload.addEventListener('progress', function(event) {
		if (xhr.c) { return; }
		_Scheduler_rawSpawn(A2($elm$core$Platform$sendToSelf, router, _Utils_Tuple2(tracker, $elm$http$Http$Sending({
			sent: event.loaded,
			size: event.total
		}))));
	});
	xhr.addEventListener('progress', function(event) {
		if (xhr.c) { return; }
		_Scheduler_rawSpawn(A2($elm$core$Platform$sendToSelf, router, _Utils_Tuple2(tracker, $elm$http$Http$Receiving({
			received: event.loaded,
			size: event.lengthComputable ? $elm$core$Maybe$Just(event.total) : $elm$core$Maybe$Nothing
		}))));
	});
}


function _Time_now(millisToPosix)
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(millisToPosix(Date.now())));
	});
}

var _Time_setInterval = F2(function(interval, task)
{
	return _Scheduler_binding(function(callback)
	{
		var id = setInterval(function() { _Scheduler_rawSpawn(task); }, interval);
		return function() { clearInterval(id); };
	});
});

function _Time_here()
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(
			A2($elm$time$Time$customZone, -(new Date().getTimezoneOffset()), _List_Nil)
		));
	});
}


function _Time_getZoneName()
{
	return _Scheduler_binding(function(callback)
	{
		try
		{
			var name = $elm$time$Time$Name(Intl.DateTimeFormat().resolvedOptions().timeZone);
		}
		catch (e)
		{
			var name = $elm$time$Time$Offset(new Date().getTimezoneOffset());
		}
		callback(_Scheduler_succeed(name));
	});
}
var $elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var $author$project$Main$LinkClicked = function (a) {
	return {$: 'LinkClicked', a: a};
};
var $elm$core$Maybe$Nothing = {$: 'Nothing'};
var $author$project$Main$UrlChanged = function (a) {
	return {$: 'UrlChanged', a: a};
};
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldr,
			helper,
			A3($elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var $elm$core$Array$toList = function (array) {
	return A3($elm$core$Array$foldr, $elm$core$List$cons, _List_Nil, array);
};
var $elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var $elm$core$Dict$toList = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					$elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Dict$keys = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2($elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Set$toList = function (_v0) {
	var dict = _v0.a;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$EQ = {$: 'EQ'};
var $elm$core$Basics$GT = {$: 'GT'};
var $elm$core$Basics$LT = {$: 'LT'};
var $elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var $elm$core$Basics$False = {$: 'False'};
var $elm$core$Basics$add = _Basics_add;
var $elm$core$String$all = _String_all;
var $elm$core$Basics$and = _Basics_and;
var $elm$core$Basics$append = _Utils_append;
var $elm$json$Json$Encode$encode = _Json_encode;
var $elm$core$String$fromInt = _String_fromNumber;
var $elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var $elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var $elm$json$Json$Decode$indent = function (str) {
	return A2(
		$elm$core$String$join,
		'\n    ',
		A2($elm$core$String$split, '\n', str));
};
var $elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var $elm$core$List$length = function (xs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var $elm$core$List$map2 = _List_map2;
var $elm$core$Basics$le = _Utils_le;
var $elm$core$Basics$sub = _Basics_sub;
var $elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2($elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var $elm$core$List$range = F2(
	function (lo, hi) {
		return A3($elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var $elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$map2,
			f,
			A2(
				$elm$core$List$range,
				0,
				$elm$core$List$length(xs) - 1),
			xs);
	});
var $elm$core$Char$toCode = _Char_toCode;
var $elm$core$Char$isLower = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var $elm$core$Char$isUpper = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var $elm$core$Basics$or = _Basics_or;
var $elm$core$Char$isAlpha = function (_char) {
	return $elm$core$Char$isLower(_char) || $elm$core$Char$isUpper(_char);
};
var $elm$core$Char$isDigit = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var $elm$core$Char$isAlphaNum = function (_char) {
	return $elm$core$Char$isLower(_char) || ($elm$core$Char$isUpper(_char) || $elm$core$Char$isDigit(_char));
};
var $elm$core$List$reverse = function (list) {
	return A3($elm$core$List$foldl, $elm$core$List$cons, _List_Nil, list);
};
var $elm$core$String$uncons = _String_uncons;
var $elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + ($elm$core$String$fromInt(i + 1) + (') ' + $elm$json$Json$Decode$indent(
			$elm$json$Json$Decode$errorToString(error))));
	});
var $elm$json$Json$Decode$errorToString = function (error) {
	return A2($elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var $elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 'Field':
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 'Nothing') {
							return false;
						} else {
							var _v2 = _v1.a;
							var _char = _v2.a;
							var rest = _v2.b;
							return $elm$core$Char$isAlpha(_char) && A2($elm$core$String$all, $elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'Index':
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'OneOf':
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									$elm$core$String$join,
									'',
									$elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										$elm$core$String$join,
										'',
										$elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + ($elm$core$String$fromInt(
								$elm$core$List$length(errors)) + ' ways:'));
							return A2(
								$elm$core$String$join,
								'\n\n',
								A2(
									$elm$core$List$cons,
									introduction,
									A2($elm$core$List$indexedMap, $elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								$elm$core$String$join,
								'',
								$elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + ($elm$json$Json$Decode$indent(
						A2($elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var $elm$core$Array$branchFactor = 32;
var $elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
	});
var $elm$core$Elm$JsArray$empty = _JsArray_empty;
var $elm$core$Basics$ceiling = _Basics_ceiling;
var $elm$core$Basics$fdiv = _Basics_fdiv;
var $elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var $elm$core$Basics$toFloat = _Basics_toFloat;
var $elm$core$Array$shiftStep = $elm$core$Basics$ceiling(
	A2($elm$core$Basics$logBase, 2, $elm$core$Array$branchFactor));
var $elm$core$Array$empty = A4($elm$core$Array$Array_elm_builtin, 0, $elm$core$Array$shiftStep, $elm$core$Elm$JsArray$empty, $elm$core$Elm$JsArray$empty);
var $elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var $elm$core$Array$Leaf = function (a) {
	return {$: 'Leaf', a: a};
};
var $elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var $elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var $elm$core$Basics$eq = _Utils_equal;
var $elm$core$Basics$floor = _Basics_floor;
var $elm$core$Elm$JsArray$length = _JsArray_length;
var $elm$core$Basics$gt = _Utils_gt;
var $elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var $elm$core$Basics$mul = _Basics_mul;
var $elm$core$Array$SubTree = function (a) {
	return {$: 'SubTree', a: a};
};
var $elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var $elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodes);
			var node = _v0.a;
			var remainingNodes = _v0.b;
			var newAcc = A2(
				$elm$core$List$cons,
				$elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return $elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var $elm$core$Tuple$first = function (_v0) {
	var x = _v0.a;
	return x;
};
var $elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = $elm$core$Basics$ceiling(nodeListSize / $elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2($elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var $elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.nodeListSize) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.tail);
		}
	});
var $elm$core$Basics$idiv = _Basics_idiv;
var $elm$core$Basics$lt = _Utils_lt;
var $elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					false,
					{nodeList: nodeList, nodeListSize: (len / $elm$core$Array$branchFactor) | 0, tail: tail});
			} else {
				var leaf = $elm$core$Array$Leaf(
					A3($elm$core$Elm$JsArray$initialize, $elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - $elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2($elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var $elm$core$Basics$remainderBy = _Basics_remainderBy;
var $elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return $elm$core$Array$empty;
		} else {
			var tailLen = len % $elm$core$Array$branchFactor;
			var tail = A3($elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - $elm$core$Array$branchFactor;
			return A5($elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var $elm$core$Basics$True = {$: 'True'};
var $elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var $elm$json$Json$Decode$andThen = _Json_andThen;
var $elm$json$Json$Decode$map = _Json_map1;
var $elm$json$Json$Decode$map2 = _Json_map2;
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $elm$virtual_dom$VirtualDom$toHandlerInt = function (handler) {
	switch (handler.$) {
		case 'Normal':
			return 0;
		case 'MayStopPropagation':
			return 1;
		case 'MayPreventDefault':
			return 2;
		default:
			return 3;
	}
};
var $elm$browser$Debugger$Expando$ArraySeq = {$: 'ArraySeq'};
var $elm$browser$Debugger$Overlay$BlockMost = {$: 'BlockMost'};
var $elm$browser$Debugger$Overlay$BlockNone = {$: 'BlockNone'};
var $elm$browser$Debugger$Expando$Constructor = F3(
	function (a, b, c) {
		return {$: 'Constructor', a: a, b: b, c: c};
	});
var $elm$browser$Debugger$Expando$Dictionary = F2(
	function (a, b) {
		return {$: 'Dictionary', a: a, b: b};
	});
var $elm$browser$Debugger$Main$Down = {$: 'Down'};
var $elm$browser$Debugger$Expando$ListSeq = {$: 'ListSeq'};
var $elm$browser$Debugger$Main$NoOp = {$: 'NoOp'};
var $elm$browser$Debugger$Expando$Primitive = function (a) {
	return {$: 'Primitive', a: a};
};
var $elm$browser$Debugger$Expando$Record = F2(
	function (a, b) {
		return {$: 'Record', a: a, b: b};
	});
var $elm$browser$Debugger$Expando$S = function (a) {
	return {$: 'S', a: a};
};
var $elm$browser$Debugger$Expando$Sequence = F3(
	function (a, b, c) {
		return {$: 'Sequence', a: a, b: b, c: c};
	});
var $elm$browser$Debugger$Expando$SetSeq = {$: 'SetSeq'};
var $elm$browser$Debugger$Main$Up = {$: 'Up'};
var $elm$browser$Debugger$Main$UserMsg = function (a) {
	return {$: 'UserMsg', a: a};
};
var $elm$browser$Debugger$Main$Export = {$: 'Export'};
var $elm$browser$Debugger$Main$Import = {$: 'Import'};
var $elm$browser$Debugger$Main$Open = {$: 'Open'};
var $elm$browser$Debugger$Main$OverlayMsg = function (a) {
	return {$: 'OverlayMsg', a: a};
};
var $elm$browser$Debugger$Main$Resume = {$: 'Resume'};
var $elm$browser$Debugger$Main$isPaused = function (state) {
	if (state.$ === 'Running') {
		return false;
	} else {
		return true;
	}
};
var $elm$browser$Debugger$History$size = function (history) {
	return history.numMessages;
};
var $elm$browser$Debugger$Overlay$Accept = function (a) {
	return {$: 'Accept', a: a};
};
var $elm$browser$Debugger$Overlay$Choose = F2(
	function (a, b) {
		return {$: 'Choose', a: a, b: b};
	});
var $elm$html$Html$div = _VirtualDom_node('div');
var $elm$json$Json$Encode$string = _Json_wrap;
var $elm$html$Html$Attributes$stringProperty = F2(
	function (key, string) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$string(string));
	});
var $elm$html$Html$Attributes$id = $elm$html$Html$Attributes$stringProperty('id');
var $elm$virtual_dom$VirtualDom$Normal = function (a) {
	return {$: 'Normal', a: a};
};
var $elm$virtual_dom$VirtualDom$on = _VirtualDom_on;
var $elm$html$Html$Events$on = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$Normal(decoder));
	});
var $elm$html$Html$Events$onClick = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'click',
		$elm$json$Json$Decode$succeed(msg));
};
var $elm$html$Html$span = _VirtualDom_node('span');
var $elm$virtual_dom$VirtualDom$style = _VirtualDom_style;
var $elm$html$Html$Attributes$style = $elm$virtual_dom$VirtualDom$style;
var $elm$virtual_dom$VirtualDom$text = _VirtualDom_text;
var $elm$html$Html$text = $elm$virtual_dom$VirtualDom$text;
var $elm$html$Html$a = _VirtualDom_node('a');
var $elm$browser$Debugger$Overlay$goodNews1 = '\nThe good news is that having values like this in your message type is not\nso great in the long run. You are better off using simpler data, like\n';
var $elm$browser$Debugger$Overlay$goodNews2 = '\nfunction can pattern match on that data and call whatever functions, JSON\ndecoders, etc. you need. This makes the code much more explicit and easy to\nfollow for other readers (or you in a few months!)\n';
var $elm$html$Html$Attributes$href = function (url) {
	return A2(
		$elm$html$Html$Attributes$stringProperty,
		'href',
		_VirtualDom_noJavaScriptUri(url));
};
var $elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							$elm$core$List$foldl,
							fn,
							acc,
							$elm$core$List$reverse(r4)) : A4($elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var $elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4($elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var $elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						$elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var $elm$html$Html$p = _VirtualDom_node('p');
var $elm$html$Html$ul = _VirtualDom_node('ul');
var $elm$html$Html$code = _VirtualDom_node('code');
var $elm$browser$Debugger$Overlay$viewCode = function (name) {
	return A2(
		$elm$html$Html$code,
		_List_Nil,
		_List_fromArray(
			[
				$elm$html$Html$text(name)
			]));
};
var $elm$browser$Debugger$Overlay$addCommas = function (items) {
	if (!items.b) {
		return '';
	} else {
		if (!items.b.b) {
			var item = items.a;
			return item;
		} else {
			if (!items.b.b.b) {
				var item1 = items.a;
				var _v1 = items.b;
				var item2 = _v1.a;
				return item1 + (' and ' + item2);
			} else {
				var lastItem = items.a;
				var otherItems = items.b;
				return A2(
					$elm$core$String$join,
					', ',
					_Utils_ap(
						otherItems,
						_List_fromArray(
							[' and ' + lastItem])));
			}
		}
	}
};
var $elm$html$Html$li = _VirtualDom_node('li');
var $elm$browser$Debugger$Overlay$problemToString = function (problem) {
	switch (problem.$) {
		case 'Function':
			return 'functions';
		case 'Decoder':
			return 'JSON decoders';
		case 'Task':
			return 'tasks';
		case 'Process':
			return 'processes';
		case 'Socket':
			return 'web sockets';
		case 'Request':
			return 'HTTP requests';
		case 'Program':
			return 'programs';
		default:
			return 'virtual DOM values';
	}
};
var $elm$browser$Debugger$Overlay$viewProblemType = function (_v0) {
	var name = _v0.name;
	var problems = _v0.problems;
	return A2(
		$elm$html$Html$li,
		_List_Nil,
		_List_fromArray(
			[
				$elm$browser$Debugger$Overlay$viewCode(name),
				$elm$html$Html$text(
				' can contain ' + ($elm$browser$Debugger$Overlay$addCommas(
					A2($elm$core$List$map, $elm$browser$Debugger$Overlay$problemToString, problems)) + '.'))
			]));
};
var $elm$browser$Debugger$Overlay$viewBadMetadata = function (_v0) {
	var message = _v0.message;
	var problems = _v0.problems;
	return _List_fromArray(
		[
			A2(
			$elm$html$Html$p,
			_List_Nil,
			_List_fromArray(
				[
					$elm$html$Html$text('The '),
					$elm$browser$Debugger$Overlay$viewCode(message),
					$elm$html$Html$text(' type of your program cannot be reliably serialized for history files.')
				])),
			A2(
			$elm$html$Html$p,
			_List_Nil,
			_List_fromArray(
				[
					$elm$html$Html$text('Functions cannot be serialized, nor can values that contain functions. This is a problem in these places:')
				])),
			A2(
			$elm$html$Html$ul,
			_List_Nil,
			A2($elm$core$List$map, $elm$browser$Debugger$Overlay$viewProblemType, problems)),
			A2(
			$elm$html$Html$p,
			_List_Nil,
			_List_fromArray(
				[
					$elm$html$Html$text($elm$browser$Debugger$Overlay$goodNews1),
					A2(
					$elm$html$Html$a,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$href('https://guide.elm-lang.org/types/custom_types.html')
						]),
					_List_fromArray(
						[
							$elm$html$Html$text('custom types')
						])),
					$elm$html$Html$text(', in your messages. From there, your '),
					$elm$browser$Debugger$Overlay$viewCode('update'),
					$elm$html$Html$text($elm$browser$Debugger$Overlay$goodNews2)
				]))
		]);
};
var $elm$virtual_dom$VirtualDom$map = _VirtualDom_map;
var $elm$html$Html$map = $elm$virtual_dom$VirtualDom$map;
var $elm$browser$Debugger$Overlay$Cancel = {$: 'Cancel'};
var $elm$browser$Debugger$Overlay$Proceed = {$: 'Proceed'};
var $elm$html$Html$button = _VirtualDom_node('button');
var $elm$browser$Debugger$Overlay$viewButtons = function (buttons) {
	var btn = F2(
		function (msg, string) {
			return A2(
				$elm$html$Html$button,
				_List_fromArray(
					[
						A2($elm$html$Html$Attributes$style, 'margin-right', '20px'),
						$elm$html$Html$Events$onClick(msg)
					]),
				_List_fromArray(
					[
						$elm$html$Html$text(string)
					]));
		});
	var buttonNodes = function () {
		if (buttons.$ === 'Accept') {
			var proceed = buttons.a;
			return _List_fromArray(
				[
					A2(btn, $elm$browser$Debugger$Overlay$Proceed, proceed)
				]);
		} else {
			var cancel = buttons.a;
			var proceed = buttons.b;
			return _List_fromArray(
				[
					A2(btn, $elm$browser$Debugger$Overlay$Cancel, cancel),
					A2(btn, $elm$browser$Debugger$Overlay$Proceed, proceed)
				]);
		}
	}();
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				A2($elm$html$Html$Attributes$style, 'height', '60px'),
				A2($elm$html$Html$Attributes$style, 'line-height', '60px'),
				A2($elm$html$Html$Attributes$style, 'text-align', 'right'),
				A2($elm$html$Html$Attributes$style, 'background-color', 'rgb(50, 50, 50)')
			]),
		buttonNodes);
};
var $elm$browser$Debugger$Overlay$viewMessage = F4(
	function (config, title, details, buttons) {
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$id('elm-debugger-overlay'),
					A2($elm$html$Html$Attributes$style, 'position', 'fixed'),
					A2($elm$html$Html$Attributes$style, 'top', '0'),
					A2($elm$html$Html$Attributes$style, 'left', '0'),
					A2($elm$html$Html$Attributes$style, 'width', '100vw'),
					A2($elm$html$Html$Attributes$style, 'height', '100vh'),
					A2($elm$html$Html$Attributes$style, 'color', 'white'),
					A2($elm$html$Html$Attributes$style, 'pointer-events', 'none'),
					A2($elm$html$Html$Attributes$style, 'font-family', '\'Trebuchet MS\', \'Lucida Grande\', \'Bitstream Vera Sans\', \'Helvetica Neue\', sans-serif'),
					A2($elm$html$Html$Attributes$style, 'z-index', '2147483647')
				]),
			_List_fromArray(
				[
					A2(
					$elm$html$Html$div,
					_List_fromArray(
						[
							A2($elm$html$Html$Attributes$style, 'position', 'absolute'),
							A2($elm$html$Html$Attributes$style, 'width', '600px'),
							A2($elm$html$Html$Attributes$style, 'height', '100vh'),
							A2($elm$html$Html$Attributes$style, 'padding-left', 'calc(50% - 300px)'),
							A2($elm$html$Html$Attributes$style, 'padding-right', 'calc(50% - 300px)'),
							A2($elm$html$Html$Attributes$style, 'background-color', 'rgba(200, 200, 200, 0.7)'),
							A2($elm$html$Html$Attributes$style, 'pointer-events', 'auto')
						]),
					_List_fromArray(
						[
							A2(
							$elm$html$Html$div,
							_List_fromArray(
								[
									A2($elm$html$Html$Attributes$style, 'font-size', '36px'),
									A2($elm$html$Html$Attributes$style, 'height', '80px'),
									A2($elm$html$Html$Attributes$style, 'background-color', 'rgb(50, 50, 50)'),
									A2($elm$html$Html$Attributes$style, 'padding-left', '22px'),
									A2($elm$html$Html$Attributes$style, 'vertical-align', 'middle'),
									A2($elm$html$Html$Attributes$style, 'line-height', '80px')
								]),
							_List_fromArray(
								[
									$elm$html$Html$text(title)
								])),
							A2(
							$elm$html$Html$div,
							_List_fromArray(
								[
									$elm$html$Html$Attributes$id('elm-debugger-details'),
									A2($elm$html$Html$Attributes$style, 'padding', ' 8px 20px'),
									A2($elm$html$Html$Attributes$style, 'overflow-y', 'auto'),
									A2($elm$html$Html$Attributes$style, 'max-height', 'calc(100vh - 156px)'),
									A2($elm$html$Html$Attributes$style, 'background-color', 'rgb(61, 61, 61)')
								]),
							details),
							A2(
							$elm$html$Html$map,
							config.wrap,
							$elm$browser$Debugger$Overlay$viewButtons(buttons))
						]))
				]));
	});
var $elm$virtual_dom$VirtualDom$attribute = F2(
	function (key, value) {
		return A2(
			_VirtualDom_attribute,
			_VirtualDom_noOnOrFormAction(key),
			_VirtualDom_noJavaScriptOrHtmlUri(value));
	});
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $elm$virtual_dom$VirtualDom$nodeNS = function (tag) {
	return _VirtualDom_nodeNS(
		_VirtualDom_noScript(tag));
};
var $elm$core$String$fromFloat = _String_fromNumber;
var $elm$browser$Debugger$Overlay$viewShape = F4(
	function (x, y, angle, coordinates) {
		return A4(
			$elm$virtual_dom$VirtualDom$nodeNS,
			'http://www.w3.org/2000/svg',
			'polygon',
			_List_fromArray(
				[
					A2($elm$virtual_dom$VirtualDom$attribute, 'points', coordinates),
					A2(
					$elm$virtual_dom$VirtualDom$attribute,
					'transform',
					'translate(' + ($elm$core$String$fromFloat(x) + (' ' + ($elm$core$String$fromFloat(y) + (') rotate(' + ($elm$core$String$fromFloat(-angle) + ')'))))))
				]),
			_List_Nil);
	});
var $elm$browser$Debugger$Overlay$elmLogo = A4(
	$elm$virtual_dom$VirtualDom$nodeNS,
	'http://www.w3.org/2000/svg',
	'svg',
	_List_fromArray(
		[
			A2($elm$virtual_dom$VirtualDom$attribute, 'viewBox', '-300 -300 600 600'),
			A2($elm$virtual_dom$VirtualDom$attribute, 'xmlns', 'http://www.w3.org/2000/svg'),
			A2($elm$virtual_dom$VirtualDom$attribute, 'fill', 'currentColor'),
			A2($elm$virtual_dom$VirtualDom$attribute, 'width', '24px'),
			A2($elm$virtual_dom$VirtualDom$attribute, 'height', '24px')
		]),
	_List_fromArray(
		[
			A4(
			$elm$virtual_dom$VirtualDom$nodeNS,
			'http://www.w3.org/2000/svg',
			'g',
			_List_fromArray(
				[
					A2($elm$virtual_dom$VirtualDom$attribute, 'transform', 'scale(1 -1)')
				]),
			_List_fromArray(
				[
					A4($elm$browser$Debugger$Overlay$viewShape, 0, -210, 0, '-280,-90 0,190 280,-90'),
					A4($elm$browser$Debugger$Overlay$viewShape, -210, 0, 90, '-280,-90 0,190 280,-90'),
					A4($elm$browser$Debugger$Overlay$viewShape, 207, 207, 45, '-198,-66 0,132 198,-66'),
					A4($elm$browser$Debugger$Overlay$viewShape, 150, 0, 0, '-130,0 0,-130 130,0 0,130'),
					A4($elm$browser$Debugger$Overlay$viewShape, -89, 239, 0, '-191,61 69,61 191,-61 -69,-61'),
					A4($elm$browser$Debugger$Overlay$viewShape, 0, 106, 180, '-130,-44 0,86  130,-44'),
					A4($elm$browser$Debugger$Overlay$viewShape, 256, -150, 270, '-130,-44 0,86  130,-44')
				]))
		]));
var $elm$core$String$length = _String_length;
var $elm$browser$Debugger$Overlay$viewMiniControls = F2(
	function (config, numMsgs) {
		var string = $elm$core$String$fromInt(numMsgs);
		var width = $elm$core$String$fromInt(
			2 + $elm$core$String$length(string));
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					A2($elm$html$Html$Attributes$style, 'position', 'fixed'),
					A2($elm$html$Html$Attributes$style, 'bottom', '2em'),
					A2($elm$html$Html$Attributes$style, 'right', '2em'),
					A2($elm$html$Html$Attributes$style, 'width', 'calc(42px + ' + (width + 'ch)')),
					A2($elm$html$Html$Attributes$style, 'height', '36px'),
					A2($elm$html$Html$Attributes$style, 'background-color', '#1293D8'),
					A2($elm$html$Html$Attributes$style, 'color', 'white'),
					A2($elm$html$Html$Attributes$style, 'font-family', 'monospace'),
					A2($elm$html$Html$Attributes$style, 'pointer-events', 'auto'),
					A2($elm$html$Html$Attributes$style, 'z-index', '2147483647'),
					A2($elm$html$Html$Attributes$style, 'display', 'flex'),
					A2($elm$html$Html$Attributes$style, 'justify-content', 'center'),
					A2($elm$html$Html$Attributes$style, 'align-items', 'center'),
					A2($elm$html$Html$Attributes$style, 'cursor', 'pointer'),
					$elm$html$Html$Events$onClick(config.open)
				]),
			_List_fromArray(
				[
					$elm$browser$Debugger$Overlay$elmLogo,
					A2(
					$elm$html$Html$span,
					_List_fromArray(
						[
							A2($elm$html$Html$Attributes$style, 'padding-left', 'calc(1ch + 6px)'),
							A2($elm$html$Html$Attributes$style, 'padding-right', '1ch')
						]),
					_List_fromArray(
						[
							$elm$html$Html$text(string)
						]))
				]));
	});
var $elm$browser$Debugger$Overlay$explanationBad = '\nThe messages in this history do not match the messages handled by your\nprogram. I noticed changes in the following types:\n';
var $elm$browser$Debugger$Overlay$explanationRisky = '\nThis history seems old. It will work with this program, but some\nmessages have been added since the history was created:\n';
var $elm$core$List$intersperse = F2(
	function (sep, xs) {
		if (!xs.b) {
			return _List_Nil;
		} else {
			var hd = xs.a;
			var tl = xs.b;
			var step = F2(
				function (x, rest) {
					return A2(
						$elm$core$List$cons,
						sep,
						A2($elm$core$List$cons, x, rest));
				});
			var spersed = A3($elm$core$List$foldr, step, _List_Nil, tl);
			return A2($elm$core$List$cons, hd, spersed);
		}
	});
var $elm$browser$Debugger$Overlay$viewMention = F2(
	function (tags, verbed) {
		var _v0 = A2(
			$elm$core$List$map,
			$elm$browser$Debugger$Overlay$viewCode,
			$elm$core$List$reverse(tags));
		if (!_v0.b) {
			return $elm$html$Html$text('');
		} else {
			if (!_v0.b.b) {
				var tag = _v0.a;
				return A2(
					$elm$html$Html$li,
					_List_Nil,
					_List_fromArray(
						[
							$elm$html$Html$text(verbed),
							tag,
							$elm$html$Html$text('.')
						]));
			} else {
				if (!_v0.b.b.b) {
					var tag2 = _v0.a;
					var _v1 = _v0.b;
					var tag1 = _v1.a;
					return A2(
						$elm$html$Html$li,
						_List_Nil,
						_List_fromArray(
							[
								$elm$html$Html$text(verbed),
								tag1,
								$elm$html$Html$text(' and '),
								tag2,
								$elm$html$Html$text('.')
							]));
				} else {
					var lastTag = _v0.a;
					var otherTags = _v0.b;
					return A2(
						$elm$html$Html$li,
						_List_Nil,
						A2(
							$elm$core$List$cons,
							$elm$html$Html$text(verbed),
							_Utils_ap(
								A2(
									$elm$core$List$intersperse,
									$elm$html$Html$text(', '),
									$elm$core$List$reverse(otherTags)),
								_List_fromArray(
									[
										$elm$html$Html$text(', and '),
										lastTag,
										$elm$html$Html$text('.')
									]))));
				}
			}
		}
	});
var $elm$browser$Debugger$Overlay$viewChange = function (change) {
	return A2(
		$elm$html$Html$li,
		_List_fromArray(
			[
				A2($elm$html$Html$Attributes$style, 'margin', '8px 0')
			]),
		function () {
			if (change.$ === 'AliasChange') {
				var name = change.a;
				return _List_fromArray(
					[
						A2(
						$elm$html$Html$span,
						_List_fromArray(
							[
								A2($elm$html$Html$Attributes$style, 'font-size', '1.5em')
							]),
						_List_fromArray(
							[
								$elm$browser$Debugger$Overlay$viewCode(name)
							]))
					]);
			} else {
				var name = change.a;
				var removed = change.b.removed;
				var changed = change.b.changed;
				var added = change.b.added;
				var argsMatch = change.b.argsMatch;
				return _List_fromArray(
					[
						A2(
						$elm$html$Html$span,
						_List_fromArray(
							[
								A2($elm$html$Html$Attributes$style, 'font-size', '1.5em')
							]),
						_List_fromArray(
							[
								$elm$browser$Debugger$Overlay$viewCode(name)
							])),
						A2(
						$elm$html$Html$ul,
						_List_fromArray(
							[
								A2($elm$html$Html$Attributes$style, 'list-style-type', 'disc'),
								A2($elm$html$Html$Attributes$style, 'padding-left', '2em')
							]),
						_List_fromArray(
							[
								A2($elm$browser$Debugger$Overlay$viewMention, removed, 'Removed '),
								A2($elm$browser$Debugger$Overlay$viewMention, changed, 'Changed '),
								A2($elm$browser$Debugger$Overlay$viewMention, added, 'Added ')
							])),
						argsMatch ? $elm$html$Html$text('') : $elm$html$Html$text('This may be due to the fact that the type variable names changed.')
					]);
			}
		}());
};
var $elm$browser$Debugger$Overlay$viewReport = F2(
	function (isBad, report) {
		switch (report.$) {
			case 'CorruptHistory':
				return _List_fromArray(
					[
						$elm$html$Html$text('Looks like this history file is corrupt. I cannot understand it.')
					]);
			case 'VersionChanged':
				var old = report.a;
				var _new = report.b;
				return _List_fromArray(
					[
						$elm$html$Html$text('This history was created with Elm ' + (old + (', but you are using Elm ' + (_new + ' right now.'))))
					]);
			case 'MessageChanged':
				var old = report.a;
				var _new = report.b;
				return _List_fromArray(
					[
						$elm$html$Html$text('To import some other history, the overall message type must' + ' be the same. The old history has '),
						$elm$browser$Debugger$Overlay$viewCode(old),
						$elm$html$Html$text(' messages, but the new program works with '),
						$elm$browser$Debugger$Overlay$viewCode(_new),
						$elm$html$Html$text(' messages.')
					]);
			default:
				var changes = report.a;
				return _List_fromArray(
					[
						A2(
						$elm$html$Html$p,
						_List_Nil,
						_List_fromArray(
							[
								$elm$html$Html$text(
								isBad ? $elm$browser$Debugger$Overlay$explanationBad : $elm$browser$Debugger$Overlay$explanationRisky)
							])),
						A2(
						$elm$html$Html$ul,
						_List_fromArray(
							[
								A2($elm$html$Html$Attributes$style, 'list-style-type', 'none'),
								A2($elm$html$Html$Attributes$style, 'padding-left', '20px')
							]),
						A2($elm$core$List$map, $elm$browser$Debugger$Overlay$viewChange, changes))
					]);
		}
	});
var $elm$browser$Debugger$Overlay$view = F5(
	function (config, isPaused, isOpen, numMsgs, state) {
		switch (state.$) {
			case 'None':
				return isOpen ? $elm$html$Html$text('') : (isPaused ? A2(
					$elm$html$Html$div,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$id('elm-debugger-overlay'),
							A2($elm$html$Html$Attributes$style, 'position', 'fixed'),
							A2($elm$html$Html$Attributes$style, 'top', '0'),
							A2($elm$html$Html$Attributes$style, 'left', '0'),
							A2($elm$html$Html$Attributes$style, 'width', '100vw'),
							A2($elm$html$Html$Attributes$style, 'height', '100vh'),
							A2($elm$html$Html$Attributes$style, 'cursor', 'pointer'),
							A2($elm$html$Html$Attributes$style, 'display', 'flex'),
							A2($elm$html$Html$Attributes$style, 'align-items', 'center'),
							A2($elm$html$Html$Attributes$style, 'justify-content', 'center'),
							A2($elm$html$Html$Attributes$style, 'pointer-events', 'auto'),
							A2($elm$html$Html$Attributes$style, 'background-color', 'rgba(200, 200, 200, 0.7)'),
							A2($elm$html$Html$Attributes$style, 'color', 'white'),
							A2($elm$html$Html$Attributes$style, 'font-family', '\'Trebuchet MS\', \'Lucida Grande\', \'Bitstream Vera Sans\', \'Helvetica Neue\', sans-serif'),
							A2($elm$html$Html$Attributes$style, 'z-index', '2147483646'),
							$elm$html$Html$Events$onClick(config.resume)
						]),
					_List_fromArray(
						[
							A2(
							$elm$html$Html$span,
							_List_fromArray(
								[
									A2($elm$html$Html$Attributes$style, 'font-size', '80px')
								]),
							_List_fromArray(
								[
									$elm$html$Html$text('Click to Resume')
								])),
							A2($elm$browser$Debugger$Overlay$viewMiniControls, config, numMsgs)
						])) : A2($elm$browser$Debugger$Overlay$viewMiniControls, config, numMsgs));
			case 'BadMetadata':
				var badMetadata_ = state.a;
				return A4(
					$elm$browser$Debugger$Overlay$viewMessage,
					config,
					'Cannot use Import or Export',
					$elm$browser$Debugger$Overlay$viewBadMetadata(badMetadata_),
					$elm$browser$Debugger$Overlay$Accept('Ok'));
			case 'BadImport':
				var report = state.a;
				return A4(
					$elm$browser$Debugger$Overlay$viewMessage,
					config,
					'Cannot Import History',
					A2($elm$browser$Debugger$Overlay$viewReport, true, report),
					$elm$browser$Debugger$Overlay$Accept('Ok'));
			default:
				var report = state.a;
				return A4(
					$elm$browser$Debugger$Overlay$viewMessage,
					config,
					'Warning',
					A2($elm$browser$Debugger$Overlay$viewReport, false, report),
					A2($elm$browser$Debugger$Overlay$Choose, 'Cancel', 'Import Anyway'));
		}
	});
var $elm$browser$Debugger$Main$cornerView = function (model) {
	return A5(
		$elm$browser$Debugger$Overlay$view,
		{exportHistory: $elm$browser$Debugger$Main$Export, importHistory: $elm$browser$Debugger$Main$Import, open: $elm$browser$Debugger$Main$Open, resume: $elm$browser$Debugger$Main$Resume, wrap: $elm$browser$Debugger$Main$OverlayMsg},
		$elm$browser$Debugger$Main$isPaused(model.state),
		_Debugger_isOpen(model.popout),
		$elm$browser$Debugger$History$size(model.history),
		model.overlay);
};
var $elm$core$Dict$RBEmpty_elm_builtin = {$: 'RBEmpty_elm_builtin'};
var $elm$core$Dict$empty = $elm$core$Dict$RBEmpty_elm_builtin;
var $elm$core$Set$foldr = F3(
	function (func, initialState, _v0) {
		var dict = _v0.a;
		return A3(
			$elm$core$Dict$foldr,
			F3(
				function (key, _v1, state) {
					return A2(func, key, state);
				}),
			initialState,
			dict);
	});
var $elm$browser$Debugger$Main$getCurrentModel = function (state) {
	if (state.$ === 'Running') {
		var model = state.a;
		return model;
	} else {
		var model = state.b;
		return model;
	}
};
var $elm$browser$Debugger$Main$getUserModel = function (model) {
	return $elm$browser$Debugger$Main$getCurrentModel(model.state);
};
var $elm$browser$Debugger$Main$initialWindowHeight = 420;
var $elm$browser$Debugger$Main$initialWindowWidth = 900;
var $elm$core$Dict$Black = {$: 'Black'};
var $elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: 'RBNode_elm_builtin', a: a, b: b, c: c, d: d, e: e};
	});
var $elm$core$Dict$Red = {$: 'Red'};
var $elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Red')) {
			var _v1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
				var _v3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					key,
					value,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) && (left.d.$ === 'RBNode_elm_builtin')) && (left.d.a.$ === 'Red')) {
				var _v5 = left.a;
				var lK = left.b;
				var lV = left.c;
				var _v6 = left.d;
				var _v7 = _v6.a;
				var llK = _v6.b;
				var llV = _v6.c;
				var llLeft = _v6.d;
				var llRight = _v6.e;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					lK,
					lV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, key, value, lRight, right));
			} else {
				return A5($elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var $elm$core$Basics$compare = _Utils_compare;
var $elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _v1 = A2($elm$core$Basics$compare, key, nKey);
			switch (_v1.$) {
				case 'LT':
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3($elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 'EQ':
					return A5($elm$core$Dict$RBNode_elm_builtin, nColor, nKey, value, nLeft, nRight);
				default:
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						nLeft,
						A3($elm$core$Dict$insertHelp, key, value, nRight));
			}
		}
	});
var $elm$core$Dict$insert = F3(
	function (key, value, dict) {
		var _v0 = A3($elm$core$Dict$insertHelp, key, value, dict);
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $elm$browser$Debugger$Main$cachedHistory = function (model) {
	var _v0 = model.state;
	if (_v0.$ === 'Running') {
		return model.history;
	} else {
		var history = _v0.e;
		return history;
	}
};
var $elm$virtual_dom$VirtualDom$node = function (tag) {
	return _VirtualDom_node(
		_VirtualDom_noScript(tag));
};
var $elm$html$Html$node = $elm$virtual_dom$VirtualDom$node;
var $elm$browser$Debugger$Main$DragEnd = {$: 'DragEnd'};
var $elm$browser$Debugger$Main$getDragStatus = function (layout) {
	if (layout.$ === 'Horizontal') {
		var status = layout.a;
		return status;
	} else {
		var status = layout.a;
		return status;
	}
};
var $elm$browser$Debugger$Main$Drag = function (a) {
	return {$: 'Drag', a: a};
};
var $elm$browser$Debugger$Main$DragInfo = F5(
	function (x, y, down, width, height) {
		return {down: down, height: height, width: width, x: x, y: y};
	});
var $elm$json$Json$Decode$field = _Json_decodeField;
var $elm$json$Json$Decode$at = F2(
	function (fields, decoder) {
		return A3($elm$core$List$foldr, $elm$json$Json$Decode$field, decoder, fields);
	});
var $elm$json$Json$Decode$float = _Json_decodeFloat;
var $elm$browser$Debugger$Main$decodeDimension = function (field) {
	return A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['currentTarget', 'ownerDocument', 'defaultView', field]),
		$elm$json$Json$Decode$float);
};
var $elm$json$Json$Decode$int = _Json_decodeInt;
var $elm$json$Json$Decode$map5 = _Json_map5;
var $elm$browser$Debugger$Main$onMouseMove = A2(
	$elm$html$Html$Events$on,
	'mousemove',
	A2(
		$elm$json$Json$Decode$map,
		$elm$browser$Debugger$Main$Drag,
		A6(
			$elm$json$Json$Decode$map5,
			$elm$browser$Debugger$Main$DragInfo,
			A2($elm$json$Json$Decode$field, 'pageX', $elm$json$Json$Decode$float),
			A2($elm$json$Json$Decode$field, 'pageY', $elm$json$Json$Decode$float),
			A2(
				$elm$json$Json$Decode$field,
				'buttons',
				A2(
					$elm$json$Json$Decode$map,
					function (v) {
						return v === 1;
					},
					$elm$json$Json$Decode$int)),
			$elm$browser$Debugger$Main$decodeDimension('innerWidth'),
			$elm$browser$Debugger$Main$decodeDimension('innerHeight'))));
var $elm$html$Html$Events$onMouseUp = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mouseup',
		$elm$json$Json$Decode$succeed(msg));
};
var $elm$browser$Debugger$Main$toDragListeners = function (layout) {
	var _v0 = $elm$browser$Debugger$Main$getDragStatus(layout);
	if (_v0.$ === 'Static') {
		return _List_Nil;
	} else {
		return _List_fromArray(
			[
				$elm$browser$Debugger$Main$onMouseMove,
				$elm$html$Html$Events$onMouseUp($elm$browser$Debugger$Main$DragEnd)
			]);
	}
};
var $elm$browser$Debugger$Main$toFlexDirection = function (layout) {
	if (layout.$ === 'Horizontal') {
		return 'row';
	} else {
		return 'column-reverse';
	}
};
var $elm$browser$Debugger$Main$DragStart = {$: 'DragStart'};
var $elm$html$Html$Events$onMouseDown = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'mousedown',
		$elm$json$Json$Decode$succeed(msg));
};
var $elm$browser$Debugger$Main$toPercent = function (fraction) {
	return $elm$core$String$fromFloat(100 * fraction) + '%';
};
var $elm$browser$Debugger$Main$viewDragZone = function (layout) {
	if (layout.$ === 'Horizontal') {
		var x = layout.b;
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					A2($elm$html$Html$Attributes$style, 'position', 'absolute'),
					A2($elm$html$Html$Attributes$style, 'top', '0'),
					A2(
					$elm$html$Html$Attributes$style,
					'left',
					$elm$browser$Debugger$Main$toPercent(x)),
					A2($elm$html$Html$Attributes$style, 'margin-left', '-5px'),
					A2($elm$html$Html$Attributes$style, 'width', '10px'),
					A2($elm$html$Html$Attributes$style, 'height', '100%'),
					A2($elm$html$Html$Attributes$style, 'cursor', 'col-resize'),
					$elm$html$Html$Events$onMouseDown($elm$browser$Debugger$Main$DragStart)
				]),
			_List_Nil);
	} else {
		var y = layout.c;
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					A2($elm$html$Html$Attributes$style, 'position', 'absolute'),
					A2(
					$elm$html$Html$Attributes$style,
					'top',
					$elm$browser$Debugger$Main$toPercent(y)),
					A2($elm$html$Html$Attributes$style, 'left', '0'),
					A2($elm$html$Html$Attributes$style, 'margin-top', '-5px'),
					A2($elm$html$Html$Attributes$style, 'width', '100%'),
					A2($elm$html$Html$Attributes$style, 'height', '10px'),
					A2($elm$html$Html$Attributes$style, 'cursor', 'row-resize'),
					$elm$html$Html$Events$onMouseDown($elm$browser$Debugger$Main$DragStart)
				]),
			_List_Nil);
	}
};
var $elm$browser$Debugger$Main$TweakExpandoModel = function (a) {
	return {$: 'TweakExpandoModel', a: a};
};
var $elm$browser$Debugger$Main$TweakExpandoMsg = function (a) {
	return {$: 'TweakExpandoMsg', a: a};
};
var $elm$browser$Debugger$Main$toExpandoPercents = function (layout) {
	if (layout.$ === 'Horizontal') {
		var x = layout.b;
		return _Utils_Tuple2(
			$elm$browser$Debugger$Main$toPercent(1 - x),
			'100%');
	} else {
		var y = layout.c;
		return _Utils_Tuple2(
			'100%',
			$elm$browser$Debugger$Main$toPercent(y));
	}
};
var $elm$browser$Debugger$Main$toMouseBlocker = function (layout) {
	var _v0 = $elm$browser$Debugger$Main$getDragStatus(layout);
	if (_v0.$ === 'Static') {
		return 'auto';
	} else {
		return 'none';
	}
};
var $elm$browser$Debugger$Expando$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$browser$Debugger$Expando$Index = F3(
	function (a, b, c) {
		return {$: 'Index', a: a, b: b, c: c};
	});
var $elm$browser$Debugger$Expando$Key = {$: 'Key'};
var $elm$browser$Debugger$Expando$None = {$: 'None'};
var $elm$browser$Debugger$Expando$Toggle = {$: 'Toggle'};
var $elm$browser$Debugger$Expando$Value = {$: 'Value'};
var $elm$browser$Debugger$Expando$blue = A2($elm$html$Html$Attributes$style, 'color', 'rgb(28, 0, 207)');
var $elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var $elm$browser$Debugger$Expando$leftPad = function (maybeKey) {
	if (maybeKey.$ === 'Nothing') {
		return _List_Nil;
	} else {
		return _List_fromArray(
			[
				A2($elm$html$Html$Attributes$style, 'padding-left', '4ch')
			]);
	}
};
var $elm$browser$Debugger$Expando$makeArrow = function (arrow) {
	return A2(
		$elm$html$Html$span,
		_List_fromArray(
			[
				A2($elm$html$Html$Attributes$style, 'color', '#777'),
				A2($elm$html$Html$Attributes$style, 'padding-left', '2ch'),
				A2($elm$html$Html$Attributes$style, 'width', '2ch'),
				A2($elm$html$Html$Attributes$style, 'display', 'inline-block')
			]),
		_List_fromArray(
			[
				$elm$html$Html$text(arrow)
			]));
};
var $elm$browser$Debugger$Expando$purple = A2($elm$html$Html$Attributes$style, 'color', 'rgb(136, 19, 145)');
var $elm$browser$Debugger$Expando$lineStarter = F3(
	function (maybeKey, maybeIsClosed, description) {
		var arrow = function () {
			if (maybeIsClosed.$ === 'Nothing') {
				return $elm$browser$Debugger$Expando$makeArrow('');
			} else {
				if (maybeIsClosed.a) {
					return $elm$browser$Debugger$Expando$makeArrow('▸');
				} else {
					return $elm$browser$Debugger$Expando$makeArrow('▾');
				}
			}
		}();
		if (maybeKey.$ === 'Nothing') {
			return A2($elm$core$List$cons, arrow, description);
		} else {
			var key = maybeKey.a;
			return A2(
				$elm$core$List$cons,
				arrow,
				A2(
					$elm$core$List$cons,
					A2(
						$elm$html$Html$span,
						_List_fromArray(
							[$elm$browser$Debugger$Expando$purple]),
						_List_fromArray(
							[
								$elm$html$Html$text(key)
							])),
					A2(
						$elm$core$List$cons,
						$elm$html$Html$text(' = '),
						description)));
		}
	});
var $elm$browser$Debugger$Expando$red = A2($elm$html$Html$Attributes$style, 'color', 'rgb(196, 26, 22)');
var $elm$core$Tuple$second = function (_v0) {
	var y = _v0.b;
	return y;
};
var $elm$browser$Debugger$Expando$seqTypeToString = F2(
	function (n, seqType) {
		switch (seqType.$) {
			case 'ListSeq':
				return 'List(' + ($elm$core$String$fromInt(n) + ')');
			case 'SetSeq':
				return 'Set(' + ($elm$core$String$fromInt(n) + ')');
			default:
				return 'Array(' + ($elm$core$String$fromInt(n) + ')');
		}
	});
var $elm$core$String$slice = _String_slice;
var $elm$core$String$left = F2(
	function (n, string) {
		return (n < 1) ? '' : A3($elm$core$String$slice, 0, n, string);
	});
var $elm$core$String$right = F2(
	function (n, string) {
		return (n < 1) ? '' : A3(
			$elm$core$String$slice,
			-n,
			$elm$core$String$length(string),
			string);
	});
var $elm$browser$Debugger$Expando$elideMiddle = function (str) {
	return ($elm$core$String$length(str) <= 18) ? str : (A2($elm$core$String$left, 8, str) + ('...' + A2($elm$core$String$right, 8, str)));
};
var $elm$core$Dict$isEmpty = function (dict) {
	if (dict.$ === 'RBEmpty_elm_builtin') {
		return true;
	} else {
		return false;
	}
};
var $elm$browser$Debugger$Expando$viewExtraTinyRecord = F3(
	function (length, starter, entries) {
		if (!entries.b) {
			return _Utils_Tuple2(
				length + 1,
				_List_fromArray(
					[
						$elm$html$Html$text('}')
					]));
		} else {
			var field = entries.a;
			var rest = entries.b;
			var nextLength = (length + $elm$core$String$length(field)) + 1;
			if (nextLength > 18) {
				return _Utils_Tuple2(
					length + 2,
					_List_fromArray(
						[
							$elm$html$Html$text('…}')
						]));
			} else {
				var _v1 = A3($elm$browser$Debugger$Expando$viewExtraTinyRecord, nextLength, ',', rest);
				var finalLength = _v1.a;
				var otherHtmls = _v1.b;
				return _Utils_Tuple2(
					finalLength,
					A2(
						$elm$core$List$cons,
						$elm$html$Html$text(starter),
						A2(
							$elm$core$List$cons,
							A2(
								$elm$html$Html$span,
								_List_fromArray(
									[$elm$browser$Debugger$Expando$purple]),
								_List_fromArray(
									[
										$elm$html$Html$text(field)
									])),
							otherHtmls)));
			}
		}
	});
var $elm$browser$Debugger$Expando$viewTinyHelp = function (str) {
	return _Utils_Tuple2(
		$elm$core$String$length(str),
		_List_fromArray(
			[
				$elm$html$Html$text(str)
			]));
};
var $elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var $elm$browser$Debugger$Expando$viewExtraTiny = function (value) {
	if (value.$ === 'Record') {
		var record = value.b;
		return A3(
			$elm$browser$Debugger$Expando$viewExtraTinyRecord,
			0,
			'{',
			$elm$core$Dict$keys(record));
	} else {
		return $elm$browser$Debugger$Expando$viewTiny(value);
	}
};
var $elm$browser$Debugger$Expando$viewTiny = function (value) {
	switch (value.$) {
		case 'S':
			var stringRep = value.a;
			var str = $elm$browser$Debugger$Expando$elideMiddle(stringRep);
			return _Utils_Tuple2(
				$elm$core$String$length(str),
				_List_fromArray(
					[
						A2(
						$elm$html$Html$span,
						_List_fromArray(
							[$elm$browser$Debugger$Expando$red]),
						_List_fromArray(
							[
								$elm$html$Html$text(str)
							]))
					]));
		case 'Primitive':
			var stringRep = value.a;
			return _Utils_Tuple2(
				$elm$core$String$length(stringRep),
				_List_fromArray(
					[
						A2(
						$elm$html$Html$span,
						_List_fromArray(
							[$elm$browser$Debugger$Expando$blue]),
						_List_fromArray(
							[
								$elm$html$Html$text(stringRep)
							]))
					]));
		case 'Sequence':
			var seqType = value.a;
			var valueList = value.c;
			return $elm$browser$Debugger$Expando$viewTinyHelp(
				A2(
					$elm$browser$Debugger$Expando$seqTypeToString,
					$elm$core$List$length(valueList),
					seqType));
		case 'Dictionary':
			var keyValuePairs = value.b;
			return $elm$browser$Debugger$Expando$viewTinyHelp(
				'Dict(' + ($elm$core$String$fromInt(
					$elm$core$List$length(keyValuePairs)) + ')'));
		case 'Record':
			var record = value.b;
			return $elm$browser$Debugger$Expando$viewTinyRecord(record);
		default:
			if (!value.c.b) {
				var maybeName = value.a;
				return $elm$browser$Debugger$Expando$viewTinyHelp(
					A2($elm$core$Maybe$withDefault, 'Unit', maybeName));
			} else {
				var maybeName = value.a;
				var valueList = value.c;
				return $elm$browser$Debugger$Expando$viewTinyHelp(
					function () {
						if (maybeName.$ === 'Nothing') {
							return 'Tuple(' + ($elm$core$String$fromInt(
								$elm$core$List$length(valueList)) + ')');
						} else {
							var name = maybeName.a;
							return name + ' …';
						}
					}());
			}
	}
};
var $elm$browser$Debugger$Expando$viewTinyRecord = function (record) {
	return $elm$core$Dict$isEmpty(record) ? _Utils_Tuple2(
		2,
		_List_fromArray(
			[
				$elm$html$Html$text('{}')
			])) : A3(
		$elm$browser$Debugger$Expando$viewTinyRecordHelp,
		0,
		'{ ',
		$elm$core$Dict$toList(record));
};
var $elm$browser$Debugger$Expando$viewTinyRecordHelp = F3(
	function (length, starter, entries) {
		if (!entries.b) {
			return _Utils_Tuple2(
				length + 2,
				_List_fromArray(
					[
						$elm$html$Html$text(' }')
					]));
		} else {
			var _v1 = entries.a;
			var field = _v1.a;
			var value = _v1.b;
			var rest = entries.b;
			var fieldLen = $elm$core$String$length(field);
			var _v2 = $elm$browser$Debugger$Expando$viewExtraTiny(value);
			var valueLen = _v2.a;
			var valueHtmls = _v2.b;
			var newLength = ((length + fieldLen) + valueLen) + 5;
			if (newLength > 60) {
				return _Utils_Tuple2(
					length + 4,
					_List_fromArray(
						[
							$elm$html$Html$text(', … }')
						]));
			} else {
				var _v3 = A3($elm$browser$Debugger$Expando$viewTinyRecordHelp, newLength, ', ', rest);
				var finalLength = _v3.a;
				var otherHtmls = _v3.b;
				return _Utils_Tuple2(
					finalLength,
					A2(
						$elm$core$List$cons,
						$elm$html$Html$text(starter),
						A2(
							$elm$core$List$cons,
							A2(
								$elm$html$Html$span,
								_List_fromArray(
									[$elm$browser$Debugger$Expando$purple]),
								_List_fromArray(
									[
										$elm$html$Html$text(field)
									])),
							A2(
								$elm$core$List$cons,
								$elm$html$Html$text(' = '),
								A2(
									$elm$core$List$cons,
									A2($elm$html$Html$span, _List_Nil, valueHtmls),
									otherHtmls)))));
			}
		}
	});
var $elm$browser$Debugger$Expando$view = F2(
	function (maybeKey, expando) {
		switch (expando.$) {
			case 'S':
				var stringRep = expando.a;
				return A2(
					$elm$html$Html$div,
					$elm$browser$Debugger$Expando$leftPad(maybeKey),
					A3(
						$elm$browser$Debugger$Expando$lineStarter,
						maybeKey,
						$elm$core$Maybe$Nothing,
						_List_fromArray(
							[
								A2(
								$elm$html$Html$span,
								_List_fromArray(
									[$elm$browser$Debugger$Expando$red]),
								_List_fromArray(
									[
										$elm$html$Html$text(stringRep)
									]))
							])));
			case 'Primitive':
				var stringRep = expando.a;
				return A2(
					$elm$html$Html$div,
					$elm$browser$Debugger$Expando$leftPad(maybeKey),
					A3(
						$elm$browser$Debugger$Expando$lineStarter,
						maybeKey,
						$elm$core$Maybe$Nothing,
						_List_fromArray(
							[
								A2(
								$elm$html$Html$span,
								_List_fromArray(
									[$elm$browser$Debugger$Expando$blue]),
								_List_fromArray(
									[
										$elm$html$Html$text(stringRep)
									]))
							])));
			case 'Sequence':
				var seqType = expando.a;
				var isClosed = expando.b;
				var valueList = expando.c;
				return A4($elm$browser$Debugger$Expando$viewSequence, maybeKey, seqType, isClosed, valueList);
			case 'Dictionary':
				var isClosed = expando.a;
				var keyValuePairs = expando.b;
				return A3($elm$browser$Debugger$Expando$viewDictionary, maybeKey, isClosed, keyValuePairs);
			case 'Record':
				var isClosed = expando.a;
				var valueDict = expando.b;
				return A3($elm$browser$Debugger$Expando$viewRecord, maybeKey, isClosed, valueDict);
			default:
				var maybeName = expando.a;
				var isClosed = expando.b;
				var valueList = expando.c;
				return A4($elm$browser$Debugger$Expando$viewConstructor, maybeKey, maybeName, isClosed, valueList);
		}
	});
var $elm$browser$Debugger$Expando$viewConstructor = F4(
	function (maybeKey, maybeName, isClosed, valueList) {
		var tinyArgs = A2(
			$elm$core$List$map,
			A2($elm$core$Basics$composeL, $elm$core$Tuple$second, $elm$browser$Debugger$Expando$viewExtraTiny),
			valueList);
		var description = function () {
			var _v7 = _Utils_Tuple2(maybeName, tinyArgs);
			if (_v7.a.$ === 'Nothing') {
				if (!_v7.b.b) {
					var _v8 = _v7.a;
					return _List_fromArray(
						[
							$elm$html$Html$text('()')
						]);
				} else {
					var _v9 = _v7.a;
					var _v10 = _v7.b;
					var x = _v10.a;
					var xs = _v10.b;
					return A2(
						$elm$core$List$cons,
						$elm$html$Html$text('( '),
						A2(
							$elm$core$List$cons,
							A2($elm$html$Html$span, _List_Nil, x),
							A3(
								$elm$core$List$foldr,
								F2(
									function (args, rest) {
										return A2(
											$elm$core$List$cons,
											$elm$html$Html$text(', '),
											A2(
												$elm$core$List$cons,
												A2($elm$html$Html$span, _List_Nil, args),
												rest));
									}),
								_List_fromArray(
									[
										$elm$html$Html$text(' )')
									]),
								xs)));
				}
			} else {
				if (!_v7.b.b) {
					var name = _v7.a.a;
					return _List_fromArray(
						[
							$elm$html$Html$text(name)
						]);
				} else {
					var name = _v7.a.a;
					var _v11 = _v7.b;
					var x = _v11.a;
					var xs = _v11.b;
					return A2(
						$elm$core$List$cons,
						$elm$html$Html$text(name + ' '),
						A2(
							$elm$core$List$cons,
							A2($elm$html$Html$span, _List_Nil, x),
							A3(
								$elm$core$List$foldr,
								F2(
									function (args, rest) {
										return A2(
											$elm$core$List$cons,
											$elm$html$Html$text(' '),
											A2(
												$elm$core$List$cons,
												A2($elm$html$Html$span, _List_Nil, args),
												rest));
									}),
								_List_Nil,
								xs)));
				}
			}
		}();
		var _v4 = function () {
			if (!valueList.b) {
				return _Utils_Tuple2(
					$elm$core$Maybe$Nothing,
					A2($elm$html$Html$div, _List_Nil, _List_Nil));
			} else {
				if (!valueList.b.b) {
					var entry = valueList.a;
					switch (entry.$) {
						case 'S':
							return _Utils_Tuple2(
								$elm$core$Maybe$Nothing,
								A2($elm$html$Html$div, _List_Nil, _List_Nil));
						case 'Primitive':
							return _Utils_Tuple2(
								$elm$core$Maybe$Nothing,
								A2($elm$html$Html$div, _List_Nil, _List_Nil));
						case 'Sequence':
							var subValueList = entry.c;
							return _Utils_Tuple2(
								$elm$core$Maybe$Just(isClosed),
								isClosed ? A2($elm$html$Html$div, _List_Nil, _List_Nil) : A2(
									$elm$html$Html$map,
									A2($elm$browser$Debugger$Expando$Index, $elm$browser$Debugger$Expando$None, 0),
									$elm$browser$Debugger$Expando$viewSequenceOpen(subValueList)));
						case 'Dictionary':
							var keyValuePairs = entry.b;
							return _Utils_Tuple2(
								$elm$core$Maybe$Just(isClosed),
								isClosed ? A2($elm$html$Html$div, _List_Nil, _List_Nil) : A2(
									$elm$html$Html$map,
									A2($elm$browser$Debugger$Expando$Index, $elm$browser$Debugger$Expando$None, 0),
									$elm$browser$Debugger$Expando$viewDictionaryOpen(keyValuePairs)));
						case 'Record':
							var record = entry.b;
							return _Utils_Tuple2(
								$elm$core$Maybe$Just(isClosed),
								isClosed ? A2($elm$html$Html$div, _List_Nil, _List_Nil) : A2(
									$elm$html$Html$map,
									A2($elm$browser$Debugger$Expando$Index, $elm$browser$Debugger$Expando$None, 0),
									$elm$browser$Debugger$Expando$viewRecordOpen(record)));
						default:
							var subValueList = entry.c;
							return _Utils_Tuple2(
								$elm$core$Maybe$Just(isClosed),
								isClosed ? A2($elm$html$Html$div, _List_Nil, _List_Nil) : A2(
									$elm$html$Html$map,
									A2($elm$browser$Debugger$Expando$Index, $elm$browser$Debugger$Expando$None, 0),
									$elm$browser$Debugger$Expando$viewConstructorOpen(subValueList)));
					}
				} else {
					return _Utils_Tuple2(
						$elm$core$Maybe$Just(isClosed),
						isClosed ? A2($elm$html$Html$div, _List_Nil, _List_Nil) : $elm$browser$Debugger$Expando$viewConstructorOpen(valueList));
				}
			}
		}();
		var maybeIsClosed = _v4.a;
		var openHtml = _v4.b;
		return A2(
			$elm$html$Html$div,
			$elm$browser$Debugger$Expando$leftPad(maybeKey),
			_List_fromArray(
				[
					A2(
					$elm$html$Html$div,
					_List_fromArray(
						[
							$elm$html$Html$Events$onClick($elm$browser$Debugger$Expando$Toggle)
						]),
					A3($elm$browser$Debugger$Expando$lineStarter, maybeKey, maybeIsClosed, description)),
					openHtml
				]));
	});
var $elm$browser$Debugger$Expando$viewConstructorEntry = F2(
	function (index, value) {
		return A2(
			$elm$html$Html$map,
			A2($elm$browser$Debugger$Expando$Index, $elm$browser$Debugger$Expando$None, index),
			A2(
				$elm$browser$Debugger$Expando$view,
				$elm$core$Maybe$Just(
					$elm$core$String$fromInt(index)),
				value));
	});
var $elm$browser$Debugger$Expando$viewConstructorOpen = function (valueList) {
	return A2(
		$elm$html$Html$div,
		_List_Nil,
		A2($elm$core$List$indexedMap, $elm$browser$Debugger$Expando$viewConstructorEntry, valueList));
};
var $elm$browser$Debugger$Expando$viewDictionary = F3(
	function (maybeKey, isClosed, keyValuePairs) {
		var starter = 'Dict(' + ($elm$core$String$fromInt(
			$elm$core$List$length(keyValuePairs)) + ')');
		return A2(
			$elm$html$Html$div,
			$elm$browser$Debugger$Expando$leftPad(maybeKey),
			_List_fromArray(
				[
					A2(
					$elm$html$Html$div,
					_List_fromArray(
						[
							$elm$html$Html$Events$onClick($elm$browser$Debugger$Expando$Toggle)
						]),
					A3(
						$elm$browser$Debugger$Expando$lineStarter,
						maybeKey,
						$elm$core$Maybe$Just(isClosed),
						_List_fromArray(
							[
								$elm$html$Html$text(starter)
							]))),
					isClosed ? $elm$html$Html$text('') : $elm$browser$Debugger$Expando$viewDictionaryOpen(keyValuePairs)
				]));
	});
var $elm$browser$Debugger$Expando$viewDictionaryEntry = F2(
	function (index, _v2) {
		var key = _v2.a;
		var value = _v2.b;
		switch (key.$) {
			case 'S':
				var stringRep = key.a;
				return A2(
					$elm$html$Html$map,
					A2($elm$browser$Debugger$Expando$Index, $elm$browser$Debugger$Expando$Value, index),
					A2(
						$elm$browser$Debugger$Expando$view,
						$elm$core$Maybe$Just(stringRep),
						value));
			case 'Primitive':
				var stringRep = key.a;
				return A2(
					$elm$html$Html$map,
					A2($elm$browser$Debugger$Expando$Index, $elm$browser$Debugger$Expando$Value, index),
					A2(
						$elm$browser$Debugger$Expando$view,
						$elm$core$Maybe$Just(stringRep),
						value));
			default:
				return A2(
					$elm$html$Html$div,
					_List_Nil,
					_List_fromArray(
						[
							A2(
							$elm$html$Html$map,
							A2($elm$browser$Debugger$Expando$Index, $elm$browser$Debugger$Expando$Key, index),
							A2(
								$elm$browser$Debugger$Expando$view,
								$elm$core$Maybe$Just('key'),
								key)),
							A2(
							$elm$html$Html$map,
							A2($elm$browser$Debugger$Expando$Index, $elm$browser$Debugger$Expando$Value, index),
							A2(
								$elm$browser$Debugger$Expando$view,
								$elm$core$Maybe$Just('value'),
								value))
						]));
		}
	});
var $elm$browser$Debugger$Expando$viewDictionaryOpen = function (keyValuePairs) {
	return A2(
		$elm$html$Html$div,
		_List_Nil,
		A2($elm$core$List$indexedMap, $elm$browser$Debugger$Expando$viewDictionaryEntry, keyValuePairs));
};
var $elm$browser$Debugger$Expando$viewRecord = F3(
	function (maybeKey, isClosed, record) {
		var _v1 = isClosed ? _Utils_Tuple3(
			$elm$browser$Debugger$Expando$viewTinyRecord(record).b,
			$elm$html$Html$text(''),
			$elm$html$Html$text('')) : _Utils_Tuple3(
			_List_fromArray(
				[
					$elm$html$Html$text('{')
				]),
			$elm$browser$Debugger$Expando$viewRecordOpen(record),
			A2(
				$elm$html$Html$div,
				$elm$browser$Debugger$Expando$leftPad(
					$elm$core$Maybe$Just(_Utils_Tuple0)),
				_List_fromArray(
					[
						$elm$html$Html$text('}')
					])));
		var start = _v1.a;
		var middle = _v1.b;
		var end = _v1.c;
		return A2(
			$elm$html$Html$div,
			$elm$browser$Debugger$Expando$leftPad(maybeKey),
			_List_fromArray(
				[
					A2(
					$elm$html$Html$div,
					_List_fromArray(
						[
							$elm$html$Html$Events$onClick($elm$browser$Debugger$Expando$Toggle)
						]),
					A3(
						$elm$browser$Debugger$Expando$lineStarter,
						maybeKey,
						$elm$core$Maybe$Just(isClosed),
						start)),
					middle,
					end
				]));
	});
var $elm$browser$Debugger$Expando$viewRecordEntry = function (_v0) {
	var field = _v0.a;
	var value = _v0.b;
	return A2(
		$elm$html$Html$map,
		$elm$browser$Debugger$Expando$Field(field),
		A2(
			$elm$browser$Debugger$Expando$view,
			$elm$core$Maybe$Just(field),
			value));
};
var $elm$browser$Debugger$Expando$viewRecordOpen = function (record) {
	return A2(
		$elm$html$Html$div,
		_List_Nil,
		A2(
			$elm$core$List$map,
			$elm$browser$Debugger$Expando$viewRecordEntry,
			$elm$core$Dict$toList(record)));
};
var $elm$browser$Debugger$Expando$viewSequence = F4(
	function (maybeKey, seqType, isClosed, valueList) {
		var starter = A2(
			$elm$browser$Debugger$Expando$seqTypeToString,
			$elm$core$List$length(valueList),
			seqType);
		return A2(
			$elm$html$Html$div,
			$elm$browser$Debugger$Expando$leftPad(maybeKey),
			_List_fromArray(
				[
					A2(
					$elm$html$Html$div,
					_List_fromArray(
						[
							$elm$html$Html$Events$onClick($elm$browser$Debugger$Expando$Toggle)
						]),
					A3(
						$elm$browser$Debugger$Expando$lineStarter,
						maybeKey,
						$elm$core$Maybe$Just(isClosed),
						_List_fromArray(
							[
								$elm$html$Html$text(starter)
							]))),
					isClosed ? $elm$html$Html$text('') : $elm$browser$Debugger$Expando$viewSequenceOpen(valueList)
				]));
	});
var $elm$browser$Debugger$Expando$viewSequenceOpen = function (values) {
	return A2(
		$elm$html$Html$div,
		_List_Nil,
		A2($elm$core$List$indexedMap, $elm$browser$Debugger$Expando$viewConstructorEntry, values));
};
var $elm$browser$Debugger$Main$viewExpando = F3(
	function (expandoMsg, expandoModel, layout) {
		var block = $elm$browser$Debugger$Main$toMouseBlocker(layout);
		var _v0 = $elm$browser$Debugger$Main$toExpandoPercents(layout);
		var w = _v0.a;
		var h = _v0.b;
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					A2($elm$html$Html$Attributes$style, 'display', 'block'),
					A2($elm$html$Html$Attributes$style, 'width', 'calc(' + (w + ' - 4em)')),
					A2($elm$html$Html$Attributes$style, 'height', 'calc(' + (h + ' - 4em)')),
					A2($elm$html$Html$Attributes$style, 'padding', '2em'),
					A2($elm$html$Html$Attributes$style, 'margin', '0'),
					A2($elm$html$Html$Attributes$style, 'overflow', 'auto'),
					A2($elm$html$Html$Attributes$style, 'pointer-events', block),
					A2($elm$html$Html$Attributes$style, '-webkit-user-select', block),
					A2($elm$html$Html$Attributes$style, '-moz-user-select', block),
					A2($elm$html$Html$Attributes$style, '-ms-user-select', block),
					A2($elm$html$Html$Attributes$style, 'user-select', block)
				]),
			_List_fromArray(
				[
					A2(
					$elm$html$Html$div,
					_List_fromArray(
						[
							A2($elm$html$Html$Attributes$style, 'color', '#ccc'),
							A2($elm$html$Html$Attributes$style, 'padding', '0 0 1em 0')
						]),
					_List_fromArray(
						[
							$elm$html$Html$text('-- MESSAGE')
						])),
					A2(
					$elm$html$Html$map,
					$elm$browser$Debugger$Main$TweakExpandoMsg,
					A2($elm$browser$Debugger$Expando$view, $elm$core$Maybe$Nothing, expandoMsg)),
					A2(
					$elm$html$Html$div,
					_List_fromArray(
						[
							A2($elm$html$Html$Attributes$style, 'color', '#ccc'),
							A2($elm$html$Html$Attributes$style, 'padding', '1em 0')
						]),
					_List_fromArray(
						[
							$elm$html$Html$text('-- MODEL')
						])),
					A2(
					$elm$html$Html$map,
					$elm$browser$Debugger$Main$TweakExpandoModel,
					A2($elm$browser$Debugger$Expando$view, $elm$core$Maybe$Nothing, expandoModel))
				]));
	});
var $elm$browser$Debugger$Main$Jump = function (a) {
	return {$: 'Jump', a: a};
};
var $elm$virtual_dom$VirtualDom$lazy = _VirtualDom_lazy;
var $elm$html$Html$Lazy$lazy = $elm$virtual_dom$VirtualDom$lazy;
var $elm$browser$Debugger$Main$toHistoryPercents = function (layout) {
	if (layout.$ === 'Horizontal') {
		var x = layout.b;
		return _Utils_Tuple2(
			$elm$browser$Debugger$Main$toPercent(x),
			'100%');
	} else {
		var y = layout.c;
		return _Utils_Tuple2(
			'100%',
			$elm$browser$Debugger$Main$toPercent(1 - y));
	}
};
var $elm$virtual_dom$VirtualDom$lazy3 = _VirtualDom_lazy3;
var $elm$html$Html$Lazy$lazy3 = $elm$virtual_dom$VirtualDom$lazy3;
var $elm$html$Html$Attributes$class = $elm$html$Html$Attributes$stringProperty('className');
var $elm$browser$Debugger$History$idForMessageIndex = function (index) {
	return 'msg-' + $elm$core$String$fromInt(index);
};
var $elm$html$Html$Attributes$title = $elm$html$Html$Attributes$stringProperty('title');
var $elm$browser$Debugger$History$viewMessage = F3(
	function (currentIndex, index, msg) {
		var messageName = _Debugger_messageToString(msg);
		var className = _Utils_eq(currentIndex, index) ? 'elm-debugger-entry elm-debugger-entry-selected' : 'elm-debugger-entry';
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$id(
					$elm$browser$Debugger$History$idForMessageIndex(index)),
					$elm$html$Html$Attributes$class(className),
					$elm$html$Html$Events$onClick(index)
				]),
			_List_fromArray(
				[
					A2(
					$elm$html$Html$span,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$title(messageName),
							$elm$html$Html$Attributes$class('elm-debugger-entry-content')
						]),
					_List_fromArray(
						[
							$elm$html$Html$text(messageName)
						])),
					A2(
					$elm$html$Html$span,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class('elm-debugger-entry-index')
						]),
					_List_fromArray(
						[
							$elm$html$Html$text(
							$elm$core$String$fromInt(index))
						]))
				]));
	});
var $elm$browser$Debugger$History$consMsg = F3(
	function (currentIndex, msg, _v0) {
		var index = _v0.a;
		var rest = _v0.b;
		return _Utils_Tuple2(
			index + 1,
			A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					$elm$core$String$fromInt(index),
					A4($elm$html$Html$Lazy$lazy3, $elm$browser$Debugger$History$viewMessage, currentIndex, index, msg)),
				rest));
	});
var $elm$core$Array$length = function (_v0) {
	var len = _v0.a;
	return len;
};
var $elm$core$Basics$neq = _Utils_notEqual;
var $elm$virtual_dom$VirtualDom$keyedNode = function (tag) {
	return _VirtualDom_keyedNode(
		_VirtualDom_noScript(tag));
};
var $elm$html$Html$Keyed$node = $elm$virtual_dom$VirtualDom$keyedNode;
var $elm$browser$Debugger$History$maxSnapshotSize = 31;
var $elm$browser$Debugger$History$showMoreButton = function (numMessages) {
	var nextIndex = (numMessages - 1) - ($elm$browser$Debugger$History$maxSnapshotSize * 2);
	var labelText = 'View more messages';
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				$elm$html$Html$Attributes$class('elm-debugger-entry'),
				$elm$html$Html$Events$onClick(nextIndex)
			]),
		_List_fromArray(
			[
				A2(
				$elm$html$Html$span,
				_List_fromArray(
					[
						$elm$html$Html$Attributes$title(labelText),
						$elm$html$Html$Attributes$class('elm-debugger-entry-content')
					]),
				_List_fromArray(
					[
						$elm$html$Html$text(labelText)
					])),
				A2(
				$elm$html$Html$span,
				_List_fromArray(
					[
						$elm$html$Html$Attributes$class('elm-debugger-entry-index')
					]),
				_List_Nil)
			]));
};
var $elm$browser$Debugger$History$styles = A3(
	$elm$html$Html$node,
	'style',
	_List_Nil,
	_List_fromArray(
		[
			$elm$html$Html$text('\n\n.elm-debugger-entry {\n  cursor: pointer;\n  width: 100%;\n  box-sizing: border-box;\n  padding: 8px;\n}\n\n.elm-debugger-entry:hover {\n  background-color: rgb(41, 41, 41);\n}\n\n.elm-debugger-entry-selected, .elm-debugger-entry-selected:hover {\n  background-color: rgb(10, 10, 10);\n}\n\n.elm-debugger-entry-content {\n  width: calc(100% - 40px);\n  padding: 0 5px;\n  box-sizing: border-box;\n  text-overflow: ellipsis;\n  white-space: nowrap;\n  overflow: hidden;\n  display: inline-block;\n}\n\n.elm-debugger-entry-index {\n  color: #666;\n  width: 40px;\n  text-align: right;\n  display: block;\n  float: right;\n}\n\n')
		]));
var $elm$core$Basics$ge = _Utils_ge;
var $elm$browser$Debugger$History$viewSnapshot = F3(
	function (selectedIndex, index, _v0) {
		var messages = _v0.messages;
		return A3(
			$elm$html$Html$Keyed$node,
			'div',
			_List_Nil,
			A3(
				$elm$core$Array$foldr,
				$elm$browser$Debugger$History$consMsg(selectedIndex),
				_Utils_Tuple2(index, _List_Nil),
				messages).b);
	});
var $elm$browser$Debugger$History$consSnapshot = F3(
	function (selectedIndex, snapshot, _v0) {
		var index = _v0.a;
		var rest = _v0.b;
		var nextIndex = index + $elm$core$Array$length(snapshot.messages);
		var selectedIndexHelp = ((_Utils_cmp(nextIndex, selectedIndex) > 0) && (_Utils_cmp(selectedIndex, index) > -1)) ? selectedIndex : (-1);
		return _Utils_Tuple2(
			nextIndex,
			A2(
				$elm$core$List$cons,
				A4($elm$html$Html$Lazy$lazy3, $elm$browser$Debugger$History$viewSnapshot, selectedIndexHelp, index, snapshot),
				rest));
	});
var $elm$core$Elm$JsArray$foldl = _JsArray_foldl;
var $elm$core$Array$foldl = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldl, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldl, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldl,
			func,
			A3($elm$core$Elm$JsArray$foldl, helper, baseCase, tree),
			tail);
	});
var $elm$browser$Debugger$History$viewAllSnapshots = F3(
	function (selectedIndex, startIndex, snapshots) {
		return A2(
			$elm$html$Html$div,
			_List_Nil,
			A3(
				$elm$core$Array$foldl,
				$elm$browser$Debugger$History$consSnapshot(selectedIndex),
				_Utils_Tuple2(startIndex, _List_Nil),
				snapshots).b);
	});
var $elm$core$Array$fromListHelp = F3(
	function (list, nodeList, nodeListSize) {
		fromListHelp:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, list);
			var jsArray = _v0.a;
			var remainingItems = _v0.b;
			if (_Utils_cmp(
				$elm$core$Elm$JsArray$length(jsArray),
				$elm$core$Array$branchFactor) < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					true,
					{nodeList: nodeList, nodeListSize: nodeListSize, tail: jsArray});
			} else {
				var $temp$list = remainingItems,
					$temp$nodeList = A2(
					$elm$core$List$cons,
					$elm$core$Array$Leaf(jsArray),
					nodeList),
					$temp$nodeListSize = nodeListSize + 1;
				list = $temp$list;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue fromListHelp;
			}
		}
	});
var $elm$core$Array$fromList = function (list) {
	if (!list.b) {
		return $elm$core$Array$empty;
	} else {
		return A3($elm$core$Array$fromListHelp, list, _List_Nil, 0);
	}
};
var $elm$core$Bitwise$and = _Bitwise_and;
var $elm$core$Bitwise$shiftRightZfBy = _Bitwise_shiftRightZfBy;
var $elm$core$Array$bitMask = 4294967295 >>> (32 - $elm$core$Array$shiftStep);
var $elm$core$Elm$JsArray$unsafeGet = _JsArray_unsafeGet;
var $elm$core$Array$getHelp = F3(
	function (shift, index, tree) {
		getHelp:
		while (true) {
			var pos = $elm$core$Array$bitMask & (index >>> shift);
			var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (_v0.$ === 'SubTree') {
				var subTree = _v0.a;
				var $temp$shift = shift - $elm$core$Array$shiftStep,
					$temp$index = index,
					$temp$tree = subTree;
				shift = $temp$shift;
				index = $temp$index;
				tree = $temp$tree;
				continue getHelp;
			} else {
				var values = _v0.a;
				return A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, values);
			}
		}
	});
var $elm$core$Bitwise$shiftLeftBy = _Bitwise_shiftLeftBy;
var $elm$core$Array$tailIndex = function (len) {
	return (len >>> 5) << 5;
};
var $elm$core$Array$get = F2(
	function (index, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		return ((index < 0) || (_Utils_cmp(index, len) > -1)) ? $elm$core$Maybe$Nothing : ((_Utils_cmp(
			index,
			$elm$core$Array$tailIndex(len)) > -1) ? $elm$core$Maybe$Just(
			A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, tail)) : $elm$core$Maybe$Just(
			A3($elm$core$Array$getHelp, startShift, index, tree)));
	});
var $elm$core$Elm$JsArray$appendN = _JsArray_appendN;
var $elm$core$Elm$JsArray$slice = _JsArray_slice;
var $elm$core$Array$appendHelpBuilder = F2(
	function (tail, builder) {
		var tailLen = $elm$core$Elm$JsArray$length(tail);
		var notAppended = ($elm$core$Array$branchFactor - $elm$core$Elm$JsArray$length(builder.tail)) - tailLen;
		var appended = A3($elm$core$Elm$JsArray$appendN, $elm$core$Array$branchFactor, builder.tail, tail);
		return (notAppended < 0) ? {
			nodeList: A2(
				$elm$core$List$cons,
				$elm$core$Array$Leaf(appended),
				builder.nodeList),
			nodeListSize: builder.nodeListSize + 1,
			tail: A3($elm$core$Elm$JsArray$slice, notAppended, tailLen, tail)
		} : ((!notAppended) ? {
			nodeList: A2(
				$elm$core$List$cons,
				$elm$core$Array$Leaf(appended),
				builder.nodeList),
			nodeListSize: builder.nodeListSize + 1,
			tail: $elm$core$Elm$JsArray$empty
		} : {nodeList: builder.nodeList, nodeListSize: builder.nodeListSize, tail: appended});
	});
var $elm$core$List$drop = F2(
	function (n, list) {
		drop:
		while (true) {
			if (n <= 0) {
				return list;
			} else {
				if (!list.b) {
					return list;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs;
					n = $temp$n;
					list = $temp$list;
					continue drop;
				}
			}
		}
	});
var $elm$core$Array$sliceLeft = F2(
	function (from, array) {
		var len = array.a;
		var tree = array.c;
		var tail = array.d;
		if (!from) {
			return array;
		} else {
			if (_Utils_cmp(
				from,
				$elm$core$Array$tailIndex(len)) > -1) {
				return A4(
					$elm$core$Array$Array_elm_builtin,
					len - from,
					$elm$core$Array$shiftStep,
					$elm$core$Elm$JsArray$empty,
					A3(
						$elm$core$Elm$JsArray$slice,
						from - $elm$core$Array$tailIndex(len),
						$elm$core$Elm$JsArray$length(tail),
						tail));
			} else {
				var skipNodes = (from / $elm$core$Array$branchFactor) | 0;
				var helper = F2(
					function (node, acc) {
						if (node.$ === 'SubTree') {
							var subTree = node.a;
							return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
						} else {
							var leaf = node.a;
							return A2($elm$core$List$cons, leaf, acc);
						}
					});
				var leafNodes = A3(
					$elm$core$Elm$JsArray$foldr,
					helper,
					_List_fromArray(
						[tail]),
					tree);
				var nodesToInsert = A2($elm$core$List$drop, skipNodes, leafNodes);
				if (!nodesToInsert.b) {
					return $elm$core$Array$empty;
				} else {
					var head = nodesToInsert.a;
					var rest = nodesToInsert.b;
					var firstSlice = from - (skipNodes * $elm$core$Array$branchFactor);
					var initialBuilder = {
						nodeList: _List_Nil,
						nodeListSize: 0,
						tail: A3(
							$elm$core$Elm$JsArray$slice,
							firstSlice,
							$elm$core$Elm$JsArray$length(head),
							head)
					};
					return A2(
						$elm$core$Array$builderToArray,
						true,
						A3($elm$core$List$foldl, $elm$core$Array$appendHelpBuilder, initialBuilder, rest));
				}
			}
		}
	});
var $elm$core$Array$fetchNewTail = F4(
	function (shift, end, treeEnd, tree) {
		fetchNewTail:
		while (true) {
			var pos = $elm$core$Array$bitMask & (treeEnd >>> shift);
			var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (_v0.$ === 'SubTree') {
				var sub = _v0.a;
				var $temp$shift = shift - $elm$core$Array$shiftStep,
					$temp$end = end,
					$temp$treeEnd = treeEnd,
					$temp$tree = sub;
				shift = $temp$shift;
				end = $temp$end;
				treeEnd = $temp$treeEnd;
				tree = $temp$tree;
				continue fetchNewTail;
			} else {
				var values = _v0.a;
				return A3($elm$core$Elm$JsArray$slice, 0, $elm$core$Array$bitMask & end, values);
			}
		}
	});
var $elm$core$Array$hoistTree = F3(
	function (oldShift, newShift, tree) {
		hoistTree:
		while (true) {
			if ((_Utils_cmp(oldShift, newShift) < 1) || (!$elm$core$Elm$JsArray$length(tree))) {
				return tree;
			} else {
				var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, 0, tree);
				if (_v0.$ === 'SubTree') {
					var sub = _v0.a;
					var $temp$oldShift = oldShift - $elm$core$Array$shiftStep,
						$temp$newShift = newShift,
						$temp$tree = sub;
					oldShift = $temp$oldShift;
					newShift = $temp$newShift;
					tree = $temp$tree;
					continue hoistTree;
				} else {
					return tree;
				}
			}
		}
	});
var $elm$core$Elm$JsArray$unsafeSet = _JsArray_unsafeSet;
var $elm$core$Array$sliceTree = F3(
	function (shift, endIdx, tree) {
		var lastPos = $elm$core$Array$bitMask & (endIdx >>> shift);
		var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, lastPos, tree);
		if (_v0.$ === 'SubTree') {
			var sub = _v0.a;
			var newSub = A3($elm$core$Array$sliceTree, shift - $elm$core$Array$shiftStep, endIdx, sub);
			return (!$elm$core$Elm$JsArray$length(newSub)) ? A3($elm$core$Elm$JsArray$slice, 0, lastPos, tree) : A3(
				$elm$core$Elm$JsArray$unsafeSet,
				lastPos,
				$elm$core$Array$SubTree(newSub),
				A3($elm$core$Elm$JsArray$slice, 0, lastPos + 1, tree));
		} else {
			return A3($elm$core$Elm$JsArray$slice, 0, lastPos, tree);
		}
	});
var $elm$core$Array$sliceRight = F2(
	function (end, array) {
		var len = array.a;
		var startShift = array.b;
		var tree = array.c;
		var tail = array.d;
		if (_Utils_eq(end, len)) {
			return array;
		} else {
			if (_Utils_cmp(
				end,
				$elm$core$Array$tailIndex(len)) > -1) {
				return A4(
					$elm$core$Array$Array_elm_builtin,
					end,
					startShift,
					tree,
					A3($elm$core$Elm$JsArray$slice, 0, $elm$core$Array$bitMask & end, tail));
			} else {
				var endIdx = $elm$core$Array$tailIndex(end);
				var depth = $elm$core$Basics$floor(
					A2(
						$elm$core$Basics$logBase,
						$elm$core$Array$branchFactor,
						A2($elm$core$Basics$max, 1, endIdx - 1)));
				var newShift = A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep);
				return A4(
					$elm$core$Array$Array_elm_builtin,
					end,
					newShift,
					A3(
						$elm$core$Array$hoistTree,
						startShift,
						newShift,
						A3($elm$core$Array$sliceTree, startShift, endIdx, tree)),
					A4($elm$core$Array$fetchNewTail, startShift, end, endIdx, tree));
			}
		}
	});
var $elm$core$Array$translateIndex = F2(
	function (index, _v0) {
		var len = _v0.a;
		var posIndex = (index < 0) ? (len + index) : index;
		return (posIndex < 0) ? 0 : ((_Utils_cmp(posIndex, len) > 0) ? len : posIndex);
	});
var $elm$core$Array$slice = F3(
	function (from, to, array) {
		var correctTo = A2($elm$core$Array$translateIndex, to, array);
		var correctFrom = A2($elm$core$Array$translateIndex, from, array);
		return (_Utils_cmp(correctFrom, correctTo) > 0) ? $elm$core$Array$empty : A2(
			$elm$core$Array$sliceLeft,
			correctFrom,
			A2($elm$core$Array$sliceRight, correctTo, array));
	});
var $elm$browser$Debugger$History$viewRecentSnapshots = F3(
	function (selectedIndex, recentMessagesNum, snapshots) {
		var messagesToFill = $elm$browser$Debugger$History$maxSnapshotSize - recentMessagesNum;
		var arrayLength = $elm$core$Array$length(snapshots);
		var snapshotsToRender = function () {
			var _v0 = _Utils_Tuple2(
				A2($elm$core$Array$get, arrayLength - 2, snapshots),
				A2($elm$core$Array$get, arrayLength - 1, snapshots));
			if ((_v0.a.$ === 'Just') && (_v0.b.$ === 'Just')) {
				var fillerSnapshot = _v0.a.a;
				var recentSnapshot = _v0.b.a;
				return $elm$core$Array$fromList(
					_List_fromArray(
						[
							{
							messages: A3($elm$core$Array$slice, 0, messagesToFill, fillerSnapshot.messages),
							model: fillerSnapshot.model
						},
							recentSnapshot
						]));
			} else {
				return snapshots;
			}
		}();
		var startingIndex = ((arrayLength * $elm$browser$Debugger$History$maxSnapshotSize) - $elm$browser$Debugger$History$maxSnapshotSize) - messagesToFill;
		return A3($elm$browser$Debugger$History$viewAllSnapshots, selectedIndex, startingIndex, snapshotsToRender);
	});
var $elm$browser$Debugger$History$view = F2(
	function (maybeIndex, _v0) {
		var snapshots = _v0.snapshots;
		var recent = _v0.recent;
		var numMessages = _v0.numMessages;
		var recentMessageStartIndex = numMessages - recent.numMessages;
		var index = A2($elm$core$Maybe$withDefault, -1, maybeIndex);
		var newStuff = A3(
			$elm$html$Html$Keyed$node,
			'div',
			_List_Nil,
			A3(
				$elm$core$List$foldr,
				$elm$browser$Debugger$History$consMsg(index),
				_Utils_Tuple2(recentMessageStartIndex, _List_Nil),
				recent.messages).b);
		var onlyRenderRecentMessages = (!_Utils_eq(index, -1)) || ($elm$core$Array$length(snapshots) < 2);
		var oldStuff = onlyRenderRecentMessages ? A4($elm$html$Html$Lazy$lazy3, $elm$browser$Debugger$History$viewAllSnapshots, index, 0, snapshots) : A4($elm$html$Html$Lazy$lazy3, $elm$browser$Debugger$History$viewRecentSnapshots, index, recent.numMessages, snapshots);
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$id('elm-debugger-sidebar'),
					A2($elm$html$Html$Attributes$style, 'width', '100%'),
					A2($elm$html$Html$Attributes$style, 'overflow-y', 'auto'),
					A2($elm$html$Html$Attributes$style, 'height', 'calc(100% - 72px)')
				]),
			A2(
				$elm$core$List$cons,
				$elm$browser$Debugger$History$styles,
				A2(
					$elm$core$List$cons,
					newStuff,
					A2(
						$elm$core$List$cons,
						oldStuff,
						onlyRenderRecentMessages ? _List_Nil : _List_fromArray(
							[
								$elm$browser$Debugger$History$showMoreButton(numMessages)
							])))));
	});
var $elm$browser$Debugger$Main$SwapLayout = {$: 'SwapLayout'};
var $elm$browser$Debugger$Main$toHistoryIcon = function (layout) {
	if (layout.$ === 'Horizontal') {
		return 'M13 1a3 3 0 0 1 3 3v8a3 3 0 0 1-3 3h-10a3 3 0 0 1-3-3v-8a3 3 0 0 1 3-3z M13 3h-10a1 1 0 0 0-1 1v5h12v-5a1 1 0 0 0-1-1z M14 10h-12v2a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1z';
	} else {
		return 'M0 4a3 3 0 0 1 3-3h10a3 3 0 0 1 3 3v8a3 3 0 0 1-3 3h-10a3 3 0 0 1-3-3z M2 4v8a1 1 0 0 0 1 1h2v-10h-2a1 1 0 0 0-1 1z M6 3v10h7a1 1 0 0 0 1-1v-8a1 1 0 0 0-1-1z';
	}
};
var $elm$browser$Debugger$Main$icon = function (path) {
	return A4(
		$elm$virtual_dom$VirtualDom$nodeNS,
		'http://www.w3.org/2000/svg',
		'svg',
		_List_fromArray(
			[
				A2($elm$virtual_dom$VirtualDom$attribute, 'viewBox', '0 0 16 16'),
				A2($elm$virtual_dom$VirtualDom$attribute, 'xmlns', 'http://www.w3.org/2000/svg'),
				A2($elm$virtual_dom$VirtualDom$attribute, 'fill', 'currentColor'),
				A2($elm$virtual_dom$VirtualDom$attribute, 'width', '16px'),
				A2($elm$virtual_dom$VirtualDom$attribute, 'height', '16px')
			]),
		_List_fromArray(
			[
				A4(
				$elm$virtual_dom$VirtualDom$nodeNS,
				'http://www.w3.org/2000/svg',
				'path',
				_List_fromArray(
					[
						A2($elm$virtual_dom$VirtualDom$attribute, 'd', path)
					]),
				_List_Nil)
			]));
};
var $elm$browser$Debugger$Main$viewHistoryButton = F3(
	function (label, msg, path) {
		return A2(
			$elm$html$Html$button,
			_List_fromArray(
				[
					A2($elm$html$Html$Attributes$style, 'display', 'flex'),
					A2($elm$html$Html$Attributes$style, 'flex-direction', 'row'),
					A2($elm$html$Html$Attributes$style, 'align-items', 'center'),
					A2($elm$html$Html$Attributes$style, 'background', 'none'),
					A2($elm$html$Html$Attributes$style, 'border', 'none'),
					A2($elm$html$Html$Attributes$style, 'color', 'inherit'),
					A2($elm$html$Html$Attributes$style, 'cursor', 'pointer'),
					$elm$html$Html$Events$onClick(msg)
				]),
			_List_fromArray(
				[
					$elm$browser$Debugger$Main$icon(path),
					A2(
					$elm$html$Html$span,
					_List_fromArray(
						[
							A2($elm$html$Html$Attributes$style, 'padding-left', '6px')
						]),
					_List_fromArray(
						[
							$elm$html$Html$text(label)
						]))
				]));
	});
var $elm$browser$Debugger$Main$viewHistoryOptions = function (layout) {
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				A2($elm$html$Html$Attributes$style, 'width', '100%'),
				A2($elm$html$Html$Attributes$style, 'height', '36px'),
				A2($elm$html$Html$Attributes$style, 'display', 'flex'),
				A2($elm$html$Html$Attributes$style, 'flex-direction', 'row'),
				A2($elm$html$Html$Attributes$style, 'align-items', 'center'),
				A2($elm$html$Html$Attributes$style, 'justify-content', 'space-between'),
				A2($elm$html$Html$Attributes$style, 'background-color', 'rgb(50, 50, 50)')
			]),
		_List_fromArray(
			[
				A3(
				$elm$browser$Debugger$Main$viewHistoryButton,
				'Swap Layout',
				$elm$browser$Debugger$Main$SwapLayout,
				$elm$browser$Debugger$Main$toHistoryIcon(layout)),
				A2(
				$elm$html$Html$div,
				_List_fromArray(
					[
						A2($elm$html$Html$Attributes$style, 'display', 'flex'),
						A2($elm$html$Html$Attributes$style, 'flex-direction', 'row'),
						A2($elm$html$Html$Attributes$style, 'align-items', 'center'),
						A2($elm$html$Html$Attributes$style, 'justify-content', 'space-between')
					]),
				_List_fromArray(
					[
						A3($elm$browser$Debugger$Main$viewHistoryButton, 'Import', $elm$browser$Debugger$Main$Import, 'M5 1a1 1 0 0 1 0 2h-2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1a1 1 0 0 1 2 0a3 3 0 0 1-3 3h-10a3 3 0 0 1-3-3v-8a3 3 0 0 1 3-3z M10 2a1 1 0 0 0 -2 0v6a1 1 0 0 0 1 1h6a1 1 0 0 0 0-2h-3.586l4.293-4.293a1 1 0 0 0-1.414-1.414l-4.293 4.293z'),
						A3($elm$browser$Debugger$Main$viewHistoryButton, 'Export', $elm$browser$Debugger$Main$Export, 'M5 1a1 1 0 0 1 0 2h-2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1 a1 1 0 0 1 2 0a3 3 0 0 1-3 3h-10a3 3 0 0 1-3-3v-8a3 3 0 0 1 3-3z M9 3a1 1 0 1 1 0-2h6a1 1 0 0 1 1 1v6a1 1 0 1 1-2 0v-3.586l-5.293 5.293 a1 1 0 0 1-1.414-1.414l5.293 -5.293z')
					]))
			]));
};
var $elm$browser$Debugger$Main$SliderJump = function (a) {
	return {$: 'SliderJump', a: a};
};
var $elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var $elm$html$Html$input = _VirtualDom_node('input');
var $elm$browser$Debugger$Main$isPlaying = function (maybeIndex) {
	if (maybeIndex.$ === 'Nothing') {
		return true;
	} else {
		return false;
	}
};
var $elm$html$Html$Attributes$max = $elm$html$Html$Attributes$stringProperty('max');
var $elm$html$Html$Attributes$min = $elm$html$Html$Attributes$stringProperty('min');
var $elm$html$Html$Events$alwaysStop = function (x) {
	return _Utils_Tuple2(x, true);
};
var $elm$virtual_dom$VirtualDom$MayStopPropagation = function (a) {
	return {$: 'MayStopPropagation', a: a};
};
var $elm$html$Html$Events$stopPropagationOn = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$MayStopPropagation(decoder));
	});
var $elm$json$Json$Decode$string = _Json_decodeString;
var $elm$html$Html$Events$targetValue = A2(
	$elm$json$Json$Decode$at,
	_List_fromArray(
		['target', 'value']),
	$elm$json$Json$Decode$string);
var $elm$html$Html$Events$onInput = function (tagger) {
	return A2(
		$elm$html$Html$Events$stopPropagationOn,
		'input',
		A2(
			$elm$json$Json$Decode$map,
			$elm$html$Html$Events$alwaysStop,
			A2($elm$json$Json$Decode$map, tagger, $elm$html$Html$Events$targetValue)));
};
var $elm$core$String$toInt = _String_toInt;
var $elm$html$Html$Attributes$type_ = $elm$html$Html$Attributes$stringProperty('type');
var $elm$html$Html$Attributes$value = $elm$html$Html$Attributes$stringProperty('value');
var $elm$browser$Debugger$Main$viewPlayButton = function (playing) {
	return A2(
		$elm$html$Html$button,
		_List_fromArray(
			[
				A2($elm$html$Html$Attributes$style, 'background', '#1293D8'),
				A2($elm$html$Html$Attributes$style, 'border', 'none'),
				A2($elm$html$Html$Attributes$style, 'color', 'white'),
				A2($elm$html$Html$Attributes$style, 'cursor', 'pointer'),
				A2($elm$html$Html$Attributes$style, 'width', '36px'),
				A2($elm$html$Html$Attributes$style, 'height', '36px'),
				$elm$html$Html$Events$onClick($elm$browser$Debugger$Main$Resume)
			]),
		_List_fromArray(
			[
				playing ? $elm$browser$Debugger$Main$icon('M2 2h4v12h-4v-12z M10 2h4v12h-4v-12z') : $elm$browser$Debugger$Main$icon('M2 2l12 7l-12 7z')
			]));
};
var $elm$browser$Debugger$Main$viewHistorySlider = F2(
	function (history, maybeIndex) {
		var lastIndex = $elm$browser$Debugger$History$size(history) - 1;
		var selectedIndex = A2($elm$core$Maybe$withDefault, lastIndex, maybeIndex);
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					A2($elm$html$Html$Attributes$style, 'display', 'flex'),
					A2($elm$html$Html$Attributes$style, 'flex-direction', 'row'),
					A2($elm$html$Html$Attributes$style, 'align-items', 'center'),
					A2($elm$html$Html$Attributes$style, 'width', '100%'),
					A2($elm$html$Html$Attributes$style, 'height', '36px'),
					A2($elm$html$Html$Attributes$style, 'background-color', 'rgb(50, 50, 50)')
				]),
			_List_fromArray(
				[
					A2(
					$elm$html$Html$Lazy$lazy,
					$elm$browser$Debugger$Main$viewPlayButton,
					$elm$browser$Debugger$Main$isPlaying(maybeIndex)),
					A2(
					$elm$html$Html$input,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$type_('range'),
							A2($elm$html$Html$Attributes$style, 'width', 'calc(100% - 56px)'),
							A2($elm$html$Html$Attributes$style, 'height', '36px'),
							A2($elm$html$Html$Attributes$style, 'margin', '0 10px'),
							$elm$html$Html$Attributes$min('0'),
							$elm$html$Html$Attributes$max(
							$elm$core$String$fromInt(lastIndex)),
							$elm$html$Html$Attributes$value(
							$elm$core$String$fromInt(selectedIndex)),
							$elm$html$Html$Events$onInput(
							A2(
								$elm$core$Basics$composeR,
								$elm$core$String$toInt,
								A2(
									$elm$core$Basics$composeR,
									$elm$core$Maybe$withDefault(lastIndex),
									$elm$browser$Debugger$Main$SliderJump)))
						]),
					_List_Nil)
				]));
	});
var $elm$browser$Debugger$Main$viewHistory = F3(
	function (maybeIndex, history, layout) {
		var block = $elm$browser$Debugger$Main$toMouseBlocker(layout);
		var _v0 = $elm$browser$Debugger$Main$toHistoryPercents(layout);
		var w = _v0.a;
		var h = _v0.b;
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					A2($elm$html$Html$Attributes$style, 'width', w),
					A2($elm$html$Html$Attributes$style, 'height', h),
					A2($elm$html$Html$Attributes$style, 'display', 'flex'),
					A2($elm$html$Html$Attributes$style, 'flex-direction', 'column'),
					A2($elm$html$Html$Attributes$style, 'color', '#DDDDDD'),
					A2($elm$html$Html$Attributes$style, 'background-color', 'rgb(61, 61, 61)'),
					A2($elm$html$Html$Attributes$style, 'pointer-events', block),
					A2($elm$html$Html$Attributes$style, 'user-select', block)
				]),
			_List_fromArray(
				[
					A2($elm$browser$Debugger$Main$viewHistorySlider, history, maybeIndex),
					A2(
					$elm$html$Html$map,
					$elm$browser$Debugger$Main$Jump,
					A2($elm$browser$Debugger$History$view, maybeIndex, history)),
					A2($elm$html$Html$Lazy$lazy, $elm$browser$Debugger$Main$viewHistoryOptions, layout)
				]));
	});
var $elm$browser$Debugger$Main$popoutView = function (model) {
	var maybeIndex = function () {
		var _v0 = model.state;
		if (_v0.$ === 'Running') {
			return $elm$core$Maybe$Nothing;
		} else {
			var index = _v0.a;
			return $elm$core$Maybe$Just(index);
		}
	}();
	var historyToRender = $elm$browser$Debugger$Main$cachedHistory(model);
	return A3(
		$elm$html$Html$node,
		'body',
		_Utils_ap(
			$elm$browser$Debugger$Main$toDragListeners(model.layout),
			_List_fromArray(
				[
					A2($elm$html$Html$Attributes$style, 'margin', '0'),
					A2($elm$html$Html$Attributes$style, 'padding', '0'),
					A2($elm$html$Html$Attributes$style, 'width', '100%'),
					A2($elm$html$Html$Attributes$style, 'height', '100%'),
					A2($elm$html$Html$Attributes$style, 'font-family', 'monospace'),
					A2($elm$html$Html$Attributes$style, 'display', 'flex'),
					A2(
					$elm$html$Html$Attributes$style,
					'flex-direction',
					$elm$browser$Debugger$Main$toFlexDirection(model.layout))
				])),
		_List_fromArray(
			[
				A3($elm$browser$Debugger$Main$viewHistory, maybeIndex, historyToRender, model.layout),
				$elm$browser$Debugger$Main$viewDragZone(model.layout),
				A3($elm$browser$Debugger$Main$viewExpando, model.expandoMsg, model.expandoModel, model.layout)
			]));
};
var $elm$browser$Debugger$Overlay$BlockAll = {$: 'BlockAll'};
var $elm$browser$Debugger$Overlay$toBlockerType = F2(
	function (isPaused, state) {
		switch (state.$) {
			case 'None':
				return isPaused ? $elm$browser$Debugger$Overlay$BlockAll : $elm$browser$Debugger$Overlay$BlockNone;
			case 'BadMetadata':
				return $elm$browser$Debugger$Overlay$BlockMost;
			case 'BadImport':
				return $elm$browser$Debugger$Overlay$BlockMost;
			default:
				return $elm$browser$Debugger$Overlay$BlockMost;
		}
	});
var $elm$browser$Debugger$Main$toBlockerType = function (model) {
	return A2(
		$elm$browser$Debugger$Overlay$toBlockerType,
		$elm$browser$Debugger$Main$isPaused(model.state),
		model.overlay);
};
var $elm$browser$Debugger$Main$Horizontal = F3(
	function (a, b, c) {
		return {$: 'Horizontal', a: a, b: b, c: c};
	});
var $elm$browser$Debugger$Main$Running = function (a) {
	return {$: 'Running', a: a};
};
var $elm$browser$Debugger$Main$Static = {$: 'Static'};
var $elm$browser$Debugger$Metadata$Error = F2(
	function (message, problems) {
		return {message: message, problems: problems};
	});
var $elm$json$Json$Decode$decodeValue = _Json_run;
var $elm$browser$Debugger$Metadata$Metadata = F2(
	function (versions, types) {
		return {types: types, versions: versions};
	});
var $elm$browser$Debugger$Metadata$Types = F3(
	function (message, aliases, unions) {
		return {aliases: aliases, message: message, unions: unions};
	});
var $elm$browser$Debugger$Metadata$Alias = F2(
	function (args, tipe) {
		return {args: args, tipe: tipe};
	});
var $elm$json$Json$Decode$list = _Json_decodeList;
var $elm$browser$Debugger$Metadata$decodeAlias = A3(
	$elm$json$Json$Decode$map2,
	$elm$browser$Debugger$Metadata$Alias,
	A2(
		$elm$json$Json$Decode$field,
		'args',
		$elm$json$Json$Decode$list($elm$json$Json$Decode$string)),
	A2($elm$json$Json$Decode$field, 'type', $elm$json$Json$Decode$string));
var $elm$browser$Debugger$Metadata$Union = F2(
	function (args, tags) {
		return {args: args, tags: tags};
	});
var $elm$core$Dict$fromList = function (assocs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, dict) {
				var key = _v0.a;
				var value = _v0.b;
				return A3($elm$core$Dict$insert, key, value, dict);
			}),
		$elm$core$Dict$empty,
		assocs);
};
var $elm$json$Json$Decode$keyValuePairs = _Json_decodeKeyValuePairs;
var $elm$json$Json$Decode$dict = function (decoder) {
	return A2(
		$elm$json$Json$Decode$map,
		$elm$core$Dict$fromList,
		$elm$json$Json$Decode$keyValuePairs(decoder));
};
var $elm$browser$Debugger$Metadata$decodeUnion = A3(
	$elm$json$Json$Decode$map2,
	$elm$browser$Debugger$Metadata$Union,
	A2(
		$elm$json$Json$Decode$field,
		'args',
		$elm$json$Json$Decode$list($elm$json$Json$Decode$string)),
	A2(
		$elm$json$Json$Decode$field,
		'tags',
		$elm$json$Json$Decode$dict(
			$elm$json$Json$Decode$list($elm$json$Json$Decode$string))));
var $elm$json$Json$Decode$map3 = _Json_map3;
var $elm$browser$Debugger$Metadata$decodeTypes = A4(
	$elm$json$Json$Decode$map3,
	$elm$browser$Debugger$Metadata$Types,
	A2($elm$json$Json$Decode$field, 'message', $elm$json$Json$Decode$string),
	A2(
		$elm$json$Json$Decode$field,
		'aliases',
		$elm$json$Json$Decode$dict($elm$browser$Debugger$Metadata$decodeAlias)),
	A2(
		$elm$json$Json$Decode$field,
		'unions',
		$elm$json$Json$Decode$dict($elm$browser$Debugger$Metadata$decodeUnion)));
var $elm$browser$Debugger$Metadata$Versions = function (elm) {
	return {elm: elm};
};
var $elm$browser$Debugger$Metadata$decodeVersions = A2(
	$elm$json$Json$Decode$map,
	$elm$browser$Debugger$Metadata$Versions,
	A2($elm$json$Json$Decode$field, 'elm', $elm$json$Json$Decode$string));
var $elm$browser$Debugger$Metadata$decoder = A3(
	$elm$json$Json$Decode$map2,
	$elm$browser$Debugger$Metadata$Metadata,
	A2($elm$json$Json$Decode$field, 'versions', $elm$browser$Debugger$Metadata$decodeVersions),
	A2($elm$json$Json$Decode$field, 'types', $elm$browser$Debugger$Metadata$decodeTypes));
var $elm$browser$Debugger$Metadata$ProblemType = F2(
	function (name, problems) {
		return {name: name, problems: problems};
	});
var $elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _v0 = f(mx);
		if (_v0.$ === 'Just') {
			var x = _v0.a;
			return A2($elm$core$List$cons, x, xs);
		} else {
			return xs;
		}
	});
var $elm$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			$elm$core$List$maybeCons(f),
			_List_Nil,
			xs);
	});
var $elm$core$String$contains = _String_contains;
var $elm$browser$Debugger$Metadata$hasProblem = F2(
	function (tipe, _v0) {
		var problem = _v0.a;
		var token = _v0.b;
		return A2($elm$core$String$contains, token, tipe) ? $elm$core$Maybe$Just(problem) : $elm$core$Maybe$Nothing;
	});
var $elm$browser$Debugger$Metadata$Decoder = {$: 'Decoder'};
var $elm$browser$Debugger$Metadata$Function = {$: 'Function'};
var $elm$browser$Debugger$Metadata$Process = {$: 'Process'};
var $elm$browser$Debugger$Metadata$Program = {$: 'Program'};
var $elm$browser$Debugger$Metadata$Request = {$: 'Request'};
var $elm$browser$Debugger$Metadata$Socket = {$: 'Socket'};
var $elm$browser$Debugger$Metadata$Task = {$: 'Task'};
var $elm$browser$Debugger$Metadata$VirtualDom = {$: 'VirtualDom'};
var $elm$browser$Debugger$Metadata$problemTable = _List_fromArray(
	[
		_Utils_Tuple2($elm$browser$Debugger$Metadata$Function, '->'),
		_Utils_Tuple2($elm$browser$Debugger$Metadata$Decoder, 'Json.Decode.Decoder'),
		_Utils_Tuple2($elm$browser$Debugger$Metadata$Task, 'Task.Task'),
		_Utils_Tuple2($elm$browser$Debugger$Metadata$Process, 'Process.Id'),
		_Utils_Tuple2($elm$browser$Debugger$Metadata$Socket, 'WebSocket.LowLevel.WebSocket'),
		_Utils_Tuple2($elm$browser$Debugger$Metadata$Request, 'Http.Request'),
		_Utils_Tuple2($elm$browser$Debugger$Metadata$Program, 'Platform.Program'),
		_Utils_Tuple2($elm$browser$Debugger$Metadata$VirtualDom, 'VirtualDom.Node'),
		_Utils_Tuple2($elm$browser$Debugger$Metadata$VirtualDom, 'VirtualDom.Attribute')
	]);
var $elm$browser$Debugger$Metadata$findProblems = function (tipe) {
	return A2(
		$elm$core$List$filterMap,
		$elm$browser$Debugger$Metadata$hasProblem(tipe),
		$elm$browser$Debugger$Metadata$problemTable);
};
var $elm$browser$Debugger$Metadata$collectBadAliases = F3(
	function (name, _v0, list) {
		var tipe = _v0.tipe;
		var _v1 = $elm$browser$Debugger$Metadata$findProblems(tipe);
		if (!_v1.b) {
			return list;
		} else {
			var problems = _v1;
			return A2(
				$elm$core$List$cons,
				A2($elm$browser$Debugger$Metadata$ProblemType, name, problems),
				list);
		}
	});
var $elm$core$List$append = F2(
	function (xs, ys) {
		if (!ys.b) {
			return xs;
		} else {
			return A3($elm$core$List$foldr, $elm$core$List$cons, ys, xs);
		}
	});
var $elm$core$List$concat = function (lists) {
	return A3($elm$core$List$foldr, $elm$core$List$append, _List_Nil, lists);
};
var $elm$core$List$concatMap = F2(
	function (f, list) {
		return $elm$core$List$concat(
			A2($elm$core$List$map, f, list));
	});
var $elm$core$Dict$values = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, valueList) {
				return A2($elm$core$List$cons, value, valueList);
			}),
		_List_Nil,
		dict);
};
var $elm$browser$Debugger$Metadata$collectBadUnions = F3(
	function (name, _v0, list) {
		var tags = _v0.tags;
		var _v1 = A2(
			$elm$core$List$concatMap,
			$elm$browser$Debugger$Metadata$findProblems,
			$elm$core$List$concat(
				$elm$core$Dict$values(tags)));
		if (!_v1.b) {
			return list;
		} else {
			var problems = _v1;
			return A2(
				$elm$core$List$cons,
				A2($elm$browser$Debugger$Metadata$ProblemType, name, problems),
				list);
		}
	});
var $elm$core$Dict$foldl = F3(
	function (func, acc, dict) {
		foldl:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldl, func, acc, left)),
					$temp$dict = right;
				func = $temp$func;
				acc = $temp$acc;
				dict = $temp$dict;
				continue foldl;
			}
		}
	});
var $elm$browser$Debugger$Metadata$isPortable = function (_v0) {
	var types = _v0.types;
	var badAliases = A3($elm$core$Dict$foldl, $elm$browser$Debugger$Metadata$collectBadAliases, _List_Nil, types.aliases);
	var _v1 = A3($elm$core$Dict$foldl, $elm$browser$Debugger$Metadata$collectBadUnions, badAliases, types.unions);
	if (!_v1.b) {
		return $elm$core$Maybe$Nothing;
	} else {
		var problems = _v1;
		return $elm$core$Maybe$Just(
			A2($elm$browser$Debugger$Metadata$Error, types.message, problems));
	}
};
var $elm$browser$Debugger$Metadata$decode = function (value) {
	var _v0 = A2($elm$json$Json$Decode$decodeValue, $elm$browser$Debugger$Metadata$decoder, value);
	if (_v0.$ === 'Err') {
		return $elm$core$Result$Err(
			A2($elm$browser$Debugger$Metadata$Error, 'The compiler is generating bad metadata. This is a compiler bug!', _List_Nil));
	} else {
		var metadata = _v0.a;
		var _v1 = $elm$browser$Debugger$Metadata$isPortable(metadata);
		if (_v1.$ === 'Nothing') {
			return $elm$core$Result$Ok(metadata);
		} else {
			var error = _v1.a;
			return $elm$core$Result$Err(error);
		}
	}
};
var $elm$browser$Debugger$History$History = F3(
	function (snapshots, recent, numMessages) {
		return {numMessages: numMessages, recent: recent, snapshots: snapshots};
	});
var $elm$browser$Debugger$History$RecentHistory = F3(
	function (model, messages, numMessages) {
		return {messages: messages, model: model, numMessages: numMessages};
	});
var $elm$browser$Debugger$History$empty = function (model) {
	return A3(
		$elm$browser$Debugger$History$History,
		$elm$core$Array$empty,
		A3($elm$browser$Debugger$History$RecentHistory, model, _List_Nil, 0),
		0);
};
var $elm$core$Dict$map = F2(
	function (func, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		} else {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				key,
				A2(func, key, value),
				A2($elm$core$Dict$map, func, left),
				A2($elm$core$Dict$map, func, right));
		}
	});
var $elm$core$Dict$sizeHelp = F2(
	function (n, dict) {
		sizeHelp:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return n;
			} else {
				var left = dict.d;
				var right = dict.e;
				var $temp$n = A2($elm$core$Dict$sizeHelp, n + 1, right),
					$temp$dict = left;
				n = $temp$n;
				dict = $temp$dict;
				continue sizeHelp;
			}
		}
	});
var $elm$core$Dict$size = function (dict) {
	return A2($elm$core$Dict$sizeHelp, 0, dict);
};
var $elm$browser$Debugger$Expando$initHelp = F2(
	function (isOuter, expando) {
		switch (expando.$) {
			case 'S':
				return expando;
			case 'Primitive':
				return expando;
			case 'Sequence':
				var seqType = expando.a;
				var isClosed = expando.b;
				var items = expando.c;
				return isOuter ? A3(
					$elm$browser$Debugger$Expando$Sequence,
					seqType,
					false,
					A2(
						$elm$core$List$map,
						$elm$browser$Debugger$Expando$initHelp(false),
						items)) : (($elm$core$List$length(items) <= 8) ? A3($elm$browser$Debugger$Expando$Sequence, seqType, false, items) : expando);
			case 'Dictionary':
				var isClosed = expando.a;
				var keyValuePairs = expando.b;
				return isOuter ? A2(
					$elm$browser$Debugger$Expando$Dictionary,
					false,
					A2(
						$elm$core$List$map,
						function (_v1) {
							var k = _v1.a;
							var v = _v1.b;
							return _Utils_Tuple2(
								k,
								A2($elm$browser$Debugger$Expando$initHelp, false, v));
						},
						keyValuePairs)) : (($elm$core$List$length(keyValuePairs) <= 8) ? A2($elm$browser$Debugger$Expando$Dictionary, false, keyValuePairs) : expando);
			case 'Record':
				var isClosed = expando.a;
				var entries = expando.b;
				return isOuter ? A2(
					$elm$browser$Debugger$Expando$Record,
					false,
					A2(
						$elm$core$Dict$map,
						F2(
							function (_v2, v) {
								return A2($elm$browser$Debugger$Expando$initHelp, false, v);
							}),
						entries)) : (($elm$core$Dict$size(entries) <= 4) ? A2($elm$browser$Debugger$Expando$Record, false, entries) : expando);
			default:
				var maybeName = expando.a;
				var isClosed = expando.b;
				var args = expando.c;
				return isOuter ? A3(
					$elm$browser$Debugger$Expando$Constructor,
					maybeName,
					false,
					A2(
						$elm$core$List$map,
						$elm$browser$Debugger$Expando$initHelp(false),
						args)) : (($elm$core$List$length(args) <= 4) ? A3($elm$browser$Debugger$Expando$Constructor, maybeName, false, args) : expando);
		}
	});
var $elm$browser$Debugger$Expando$init = function (value) {
	return A2(
		$elm$browser$Debugger$Expando$initHelp,
		true,
		_Debugger_init(value));
};
var $elm$core$Platform$Cmd$map = _Platform_map;
var $elm$browser$Debugger$Overlay$None = {$: 'None'};
var $elm$browser$Debugger$Overlay$none = $elm$browser$Debugger$Overlay$None;
var $elm$browser$Debugger$Main$wrapInit = F4(
	function (metadata, popout, init, flags) {
		var _v0 = init(flags);
		var userModel = _v0.a;
		var userCommands = _v0.b;
		return _Utils_Tuple2(
			{
				expandoModel: $elm$browser$Debugger$Expando$init(userModel),
				expandoMsg: $elm$browser$Debugger$Expando$init(_Utils_Tuple0),
				history: $elm$browser$Debugger$History$empty(userModel),
				layout: A3($elm$browser$Debugger$Main$Horizontal, $elm$browser$Debugger$Main$Static, 0.3, 0.5),
				metadata: $elm$browser$Debugger$Metadata$decode(metadata),
				overlay: $elm$browser$Debugger$Overlay$none,
				popout: popout,
				state: $elm$browser$Debugger$Main$Running(userModel)
			},
			A2($elm$core$Platform$Cmd$map, $elm$browser$Debugger$Main$UserMsg, userCommands));
	});
var $elm$browser$Debugger$Main$getLatestModel = function (state) {
	if (state.$ === 'Running') {
		var model = state.a;
		return model;
	} else {
		var model = state.c;
		return model;
	}
};
var $elm$core$Platform$Sub$map = _Platform_map;
var $elm$browser$Debugger$Main$wrapSubs = F2(
	function (subscriptions, model) {
		return A2(
			$elm$core$Platform$Sub$map,
			$elm$browser$Debugger$Main$UserMsg,
			subscriptions(
				$elm$browser$Debugger$Main$getLatestModel(model.state)));
	});
var $elm$browser$Debugger$Main$Moving = {$: 'Moving'};
var $elm$browser$Debugger$Main$Paused = F5(
	function (a, b, c, d, e) {
		return {$: 'Paused', a: a, b: b, c: c, d: d, e: e};
	});
var $elm$browser$Debugger$History$Snapshot = F2(
	function (model, messages) {
		return {messages: messages, model: model};
	});
var $elm$browser$Debugger$History$addRecent = F3(
	function (msg, newModel, _v0) {
		var model = _v0.model;
		var messages = _v0.messages;
		var numMessages = _v0.numMessages;
		return _Utils_eq(numMessages, $elm$browser$Debugger$History$maxSnapshotSize) ? _Utils_Tuple2(
			$elm$core$Maybe$Just(
				A2(
					$elm$browser$Debugger$History$Snapshot,
					model,
					$elm$core$Array$fromList(messages))),
			A3(
				$elm$browser$Debugger$History$RecentHistory,
				newModel,
				_List_fromArray(
					[msg]),
				1)) : _Utils_Tuple2(
			$elm$core$Maybe$Nothing,
			A3(
				$elm$browser$Debugger$History$RecentHistory,
				model,
				A2($elm$core$List$cons, msg, messages),
				numMessages + 1));
	});
var $elm$core$Elm$JsArray$push = _JsArray_push;
var $elm$core$Elm$JsArray$singleton = _JsArray_singleton;
var $elm$core$Array$insertTailInTree = F4(
	function (shift, index, tail, tree) {
		var pos = $elm$core$Array$bitMask & (index >>> shift);
		if (_Utils_cmp(
			pos,
			$elm$core$Elm$JsArray$length(tree)) > -1) {
			if (shift === 5) {
				return A2(
					$elm$core$Elm$JsArray$push,
					$elm$core$Array$Leaf(tail),
					tree);
			} else {
				var newSub = $elm$core$Array$SubTree(
					A4($elm$core$Array$insertTailInTree, shift - $elm$core$Array$shiftStep, index, tail, $elm$core$Elm$JsArray$empty));
				return A2($elm$core$Elm$JsArray$push, newSub, tree);
			}
		} else {
			var value = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (value.$ === 'SubTree') {
				var subTree = value.a;
				var newSub = $elm$core$Array$SubTree(
					A4($elm$core$Array$insertTailInTree, shift - $elm$core$Array$shiftStep, index, tail, subTree));
				return A3($elm$core$Elm$JsArray$unsafeSet, pos, newSub, tree);
			} else {
				var newSub = $elm$core$Array$SubTree(
					A4(
						$elm$core$Array$insertTailInTree,
						shift - $elm$core$Array$shiftStep,
						index,
						tail,
						$elm$core$Elm$JsArray$singleton(value)));
				return A3($elm$core$Elm$JsArray$unsafeSet, pos, newSub, tree);
			}
		}
	});
var $elm$core$Array$unsafeReplaceTail = F2(
	function (newTail, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		var originalTailLen = $elm$core$Elm$JsArray$length(tail);
		var newTailLen = $elm$core$Elm$JsArray$length(newTail);
		var newArrayLen = len + (newTailLen - originalTailLen);
		if (_Utils_eq(newTailLen, $elm$core$Array$branchFactor)) {
			var overflow = _Utils_cmp(newArrayLen >>> $elm$core$Array$shiftStep, 1 << startShift) > 0;
			if (overflow) {
				var newShift = startShift + $elm$core$Array$shiftStep;
				var newTree = A4(
					$elm$core$Array$insertTailInTree,
					newShift,
					len,
					newTail,
					$elm$core$Elm$JsArray$singleton(
						$elm$core$Array$SubTree(tree)));
				return A4($elm$core$Array$Array_elm_builtin, newArrayLen, newShift, newTree, $elm$core$Elm$JsArray$empty);
			} else {
				return A4(
					$elm$core$Array$Array_elm_builtin,
					newArrayLen,
					startShift,
					A4($elm$core$Array$insertTailInTree, startShift, len, newTail, tree),
					$elm$core$Elm$JsArray$empty);
			}
		} else {
			return A4($elm$core$Array$Array_elm_builtin, newArrayLen, startShift, tree, newTail);
		}
	});
var $elm$core$Array$push = F2(
	function (a, array) {
		var tail = array.d;
		return A2(
			$elm$core$Array$unsafeReplaceTail,
			A2($elm$core$Elm$JsArray$push, a, tail),
			array);
	});
var $elm$browser$Debugger$History$add = F3(
	function (msg, model, _v0) {
		var snapshots = _v0.snapshots;
		var recent = _v0.recent;
		var numMessages = _v0.numMessages;
		var _v1 = A3($elm$browser$Debugger$History$addRecent, msg, model, recent);
		if (_v1.a.$ === 'Just') {
			var snapshot = _v1.a.a;
			var newRecent = _v1.b;
			return A3(
				$elm$browser$Debugger$History$History,
				A2($elm$core$Array$push, snapshot, snapshots),
				newRecent,
				numMessages + 1);
		} else {
			var _v2 = _v1.a;
			var newRecent = _v1.b;
			return A3($elm$browser$Debugger$History$History, snapshots, newRecent, numMessages + 1);
		}
	});
var $elm$core$Basics$always = F2(
	function (a, _v0) {
		return a;
	});
var $elm$browser$Debugger$Overlay$BadImport = function (a) {
	return {$: 'BadImport', a: a};
};
var $elm$browser$Debugger$Overlay$RiskyImport = F2(
	function (a, b) {
		return {$: 'RiskyImport', a: a, b: b};
	});
var $elm$browser$Debugger$Report$VersionChanged = F2(
	function (a, b) {
		return {$: 'VersionChanged', a: a, b: b};
	});
var $elm$browser$Debugger$Report$MessageChanged = F2(
	function (a, b) {
		return {$: 'MessageChanged', a: a, b: b};
	});
var $elm$browser$Debugger$Report$SomethingChanged = function (a) {
	return {$: 'SomethingChanged', a: a};
};
var $elm$browser$Debugger$Report$AliasChange = function (a) {
	return {$: 'AliasChange', a: a};
};
var $elm$browser$Debugger$Metadata$checkAlias = F4(
	function (name, old, _new, changes) {
		return (_Utils_eq(old.tipe, _new.tipe) && _Utils_eq(old.args, _new.args)) ? changes : A2(
			$elm$core$List$cons,
			$elm$browser$Debugger$Report$AliasChange(name),
			changes);
	});
var $elm$browser$Debugger$Report$UnionChange = F2(
	function (a, b) {
		return {$: 'UnionChange', a: a, b: b};
	});
var $elm$browser$Debugger$Metadata$addTag = F3(
	function (tag, _v0, changes) {
		return _Utils_update(
			changes,
			{
				added: A2($elm$core$List$cons, tag, changes.added)
			});
	});
var $elm$browser$Debugger$Metadata$checkTag = F4(
	function (tag, old, _new, changes) {
		return _Utils_eq(old, _new) ? changes : _Utils_update(
			changes,
			{
				changed: A2($elm$core$List$cons, tag, changes.changed)
			});
	});
var $elm$browser$Debugger$Report$TagChanges = F4(
	function (removed, changed, added, argsMatch) {
		return {added: added, argsMatch: argsMatch, changed: changed, removed: removed};
	});
var $elm$browser$Debugger$Report$emptyTagChanges = function (argsMatch) {
	return A4($elm$browser$Debugger$Report$TagChanges, _List_Nil, _List_Nil, _List_Nil, argsMatch);
};
var $elm$browser$Debugger$Report$hasTagChanges = function (tagChanges) {
	return _Utils_eq(
		tagChanges,
		A4($elm$browser$Debugger$Report$TagChanges, _List_Nil, _List_Nil, _List_Nil, true));
};
var $elm$core$Dict$merge = F6(
	function (leftStep, bothStep, rightStep, leftDict, rightDict, initialResult) {
		var stepState = F3(
			function (rKey, rValue, _v0) {
				stepState:
				while (true) {
					var list = _v0.a;
					var result = _v0.b;
					if (!list.b) {
						return _Utils_Tuple2(
							list,
							A3(rightStep, rKey, rValue, result));
					} else {
						var _v2 = list.a;
						var lKey = _v2.a;
						var lValue = _v2.b;
						var rest = list.b;
						if (_Utils_cmp(lKey, rKey) < 0) {
							var $temp$rKey = rKey,
								$temp$rValue = rValue,
								$temp$_v0 = _Utils_Tuple2(
								rest,
								A3(leftStep, lKey, lValue, result));
							rKey = $temp$rKey;
							rValue = $temp$rValue;
							_v0 = $temp$_v0;
							continue stepState;
						} else {
							if (_Utils_cmp(lKey, rKey) > 0) {
								return _Utils_Tuple2(
									list,
									A3(rightStep, rKey, rValue, result));
							} else {
								return _Utils_Tuple2(
									rest,
									A4(bothStep, lKey, lValue, rValue, result));
							}
						}
					}
				}
			});
		var _v3 = A3(
			$elm$core$Dict$foldl,
			stepState,
			_Utils_Tuple2(
				$elm$core$Dict$toList(leftDict),
				initialResult),
			rightDict);
		var leftovers = _v3.a;
		var intermediateResult = _v3.b;
		return A3(
			$elm$core$List$foldl,
			F2(
				function (_v4, result) {
					var k = _v4.a;
					var v = _v4.b;
					return A3(leftStep, k, v, result);
				}),
			intermediateResult,
			leftovers);
	});
var $elm$browser$Debugger$Metadata$removeTag = F3(
	function (tag, _v0, changes) {
		return _Utils_update(
			changes,
			{
				removed: A2($elm$core$List$cons, tag, changes.removed)
			});
	});
var $elm$browser$Debugger$Metadata$checkUnion = F4(
	function (name, old, _new, changes) {
		var tagChanges = A6(
			$elm$core$Dict$merge,
			$elm$browser$Debugger$Metadata$removeTag,
			$elm$browser$Debugger$Metadata$checkTag,
			$elm$browser$Debugger$Metadata$addTag,
			old.tags,
			_new.tags,
			$elm$browser$Debugger$Report$emptyTagChanges(
				_Utils_eq(old.args, _new.args)));
		return $elm$browser$Debugger$Report$hasTagChanges(tagChanges) ? changes : A2(
			$elm$core$List$cons,
			A2($elm$browser$Debugger$Report$UnionChange, name, tagChanges),
			changes);
	});
var $elm$browser$Debugger$Metadata$ignore = F3(
	function (key, value, report) {
		return report;
	});
var $elm$browser$Debugger$Metadata$checkTypes = F2(
	function (old, _new) {
		return (!_Utils_eq(old.message, _new.message)) ? A2($elm$browser$Debugger$Report$MessageChanged, old.message, _new.message) : $elm$browser$Debugger$Report$SomethingChanged(
			A6(
				$elm$core$Dict$merge,
				$elm$browser$Debugger$Metadata$ignore,
				$elm$browser$Debugger$Metadata$checkUnion,
				$elm$browser$Debugger$Metadata$ignore,
				old.unions,
				_new.unions,
				A6($elm$core$Dict$merge, $elm$browser$Debugger$Metadata$ignore, $elm$browser$Debugger$Metadata$checkAlias, $elm$browser$Debugger$Metadata$ignore, old.aliases, _new.aliases, _List_Nil)));
	});
var $elm$browser$Debugger$Metadata$check = F2(
	function (old, _new) {
		return (!_Utils_eq(old.versions.elm, _new.versions.elm)) ? A2($elm$browser$Debugger$Report$VersionChanged, old.versions.elm, _new.versions.elm) : A2($elm$browser$Debugger$Metadata$checkTypes, old.types, _new.types);
	});
var $elm$browser$Debugger$Report$CorruptHistory = {$: 'CorruptHistory'};
var $elm$browser$Debugger$Overlay$corruptImport = $elm$browser$Debugger$Overlay$BadImport($elm$browser$Debugger$Report$CorruptHistory);
var $elm$json$Json$Decode$decodeString = _Json_runOnString;
var $elm$browser$Debugger$Report$Fine = {$: 'Fine'};
var $elm$browser$Debugger$Report$Impossible = {$: 'Impossible'};
var $elm$browser$Debugger$Report$Risky = {$: 'Risky'};
var $elm$core$Basics$not = _Basics_not;
var $elm$core$List$isEmpty = function (xs) {
	if (!xs.b) {
		return true;
	} else {
		return false;
	}
};
var $elm$browser$Debugger$Report$some = function (list) {
	return !$elm$core$List$isEmpty(list);
};
var $elm$browser$Debugger$Report$evaluateChange = function (change) {
	if (change.$ === 'AliasChange') {
		return $elm$browser$Debugger$Report$Impossible;
	} else {
		var removed = change.b.removed;
		var changed = change.b.changed;
		var added = change.b.added;
		var argsMatch = change.b.argsMatch;
		return ((!argsMatch) || ($elm$browser$Debugger$Report$some(changed) || $elm$browser$Debugger$Report$some(removed))) ? $elm$browser$Debugger$Report$Impossible : ($elm$browser$Debugger$Report$some(added) ? $elm$browser$Debugger$Report$Risky : $elm$browser$Debugger$Report$Fine);
	}
};
var $elm$browser$Debugger$Report$worstCase = F2(
	function (status, statusList) {
		worstCase:
		while (true) {
			if (!statusList.b) {
				return status;
			} else {
				switch (statusList.a.$) {
					case 'Impossible':
						var _v1 = statusList.a;
						return $elm$browser$Debugger$Report$Impossible;
					case 'Risky':
						var _v2 = statusList.a;
						var rest = statusList.b;
						var $temp$status = $elm$browser$Debugger$Report$Risky,
							$temp$statusList = rest;
						status = $temp$status;
						statusList = $temp$statusList;
						continue worstCase;
					default:
						var _v3 = statusList.a;
						var rest = statusList.b;
						var $temp$status = status,
							$temp$statusList = rest;
						status = $temp$status;
						statusList = $temp$statusList;
						continue worstCase;
				}
			}
		}
	});
var $elm$browser$Debugger$Report$evaluate = function (report) {
	switch (report.$) {
		case 'CorruptHistory':
			return $elm$browser$Debugger$Report$Impossible;
		case 'VersionChanged':
			return $elm$browser$Debugger$Report$Impossible;
		case 'MessageChanged':
			return $elm$browser$Debugger$Report$Impossible;
		default:
			var changes = report.a;
			return A2(
				$elm$browser$Debugger$Report$worstCase,
				$elm$browser$Debugger$Report$Fine,
				A2($elm$core$List$map, $elm$browser$Debugger$Report$evaluateChange, changes));
	}
};
var $elm$json$Json$Decode$value = _Json_decodeValue;
var $elm$browser$Debugger$Overlay$uploadDecoder = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (x, y) {
			return _Utils_Tuple2(x, y);
		}),
	A2($elm$json$Json$Decode$field, 'metadata', $elm$browser$Debugger$Metadata$decoder),
	A2($elm$json$Json$Decode$field, 'history', $elm$json$Json$Decode$value));
var $elm$browser$Debugger$Overlay$assessImport = F2(
	function (metadata, jsonString) {
		var _v0 = A2($elm$json$Json$Decode$decodeString, $elm$browser$Debugger$Overlay$uploadDecoder, jsonString);
		if (_v0.$ === 'Err') {
			return $elm$core$Result$Err($elm$browser$Debugger$Overlay$corruptImport);
		} else {
			var _v1 = _v0.a;
			var foreignMetadata = _v1.a;
			var rawHistory = _v1.b;
			var report = A2($elm$browser$Debugger$Metadata$check, foreignMetadata, metadata);
			var _v2 = $elm$browser$Debugger$Report$evaluate(report);
			switch (_v2.$) {
				case 'Impossible':
					return $elm$core$Result$Err(
						$elm$browser$Debugger$Overlay$BadImport(report));
				case 'Risky':
					return $elm$core$Result$Err(
						A2($elm$browser$Debugger$Overlay$RiskyImport, report, rawHistory));
				default:
					return $elm$core$Result$Ok(rawHistory);
			}
		}
	});
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $elm$browser$Debugger$Overlay$close = F2(
	function (msg, state) {
		switch (state.$) {
			case 'None':
				return $elm$core$Maybe$Nothing;
			case 'BadMetadata':
				return $elm$core$Maybe$Nothing;
			case 'BadImport':
				return $elm$core$Maybe$Nothing;
			default:
				var rawHistory = state.b;
				if (msg.$ === 'Cancel') {
					return $elm$core$Maybe$Nothing;
				} else {
					return $elm$core$Maybe$Just(rawHistory);
				}
		}
	});
var $elm$browser$Debugger$History$elmToJs = A2($elm$core$Basics$composeR, _Json_wrap, _Debugger_unsafeCoerce);
var $elm$browser$Debugger$History$encodeHelp = F2(
	function (snapshot, allMessages) {
		return A3($elm$core$Array$foldl, $elm$core$List$cons, allMessages, snapshot.messages);
	});
var $elm$json$Json$Encode$list = F2(
	function (func, entries) {
		return _Json_wrap(
			A3(
				$elm$core$List$foldl,
				_Json_addEntry(func),
				_Json_emptyArray(_Utils_Tuple0),
				entries));
	});
var $elm$browser$Debugger$History$encode = function (_v0) {
	var snapshots = _v0.snapshots;
	var recent = _v0.recent;
	return A2(
		$elm$json$Json$Encode$list,
		$elm$browser$Debugger$History$elmToJs,
		A3(
			$elm$core$Array$foldr,
			$elm$browser$Debugger$History$encodeHelp,
			$elm$core$List$reverse(recent.messages),
			snapshots));
};
var $elm$json$Json$Encode$object = function (pairs) {
	return _Json_wrap(
		A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, obj) {
					var k = _v0.a;
					var v = _v0.b;
					return A3(_Json_addField, k, v, obj);
				}),
			_Json_emptyObject(_Utils_Tuple0),
			pairs));
};
var $elm$browser$Debugger$Metadata$encodeAlias = function (_v0) {
	var args = _v0.args;
	var tipe = _v0.tipe;
	return $elm$json$Json$Encode$object(
		_List_fromArray(
			[
				_Utils_Tuple2(
				'args',
				A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, args)),
				_Utils_Tuple2(
				'type',
				$elm$json$Json$Encode$string(tipe))
			]));
};
var $elm$browser$Debugger$Metadata$encodeDict = F2(
	function (f, dict) {
		return $elm$json$Json$Encode$object(
			$elm$core$Dict$toList(
				A2(
					$elm$core$Dict$map,
					F2(
						function (key, value) {
							return f(value);
						}),
					dict)));
	});
var $elm$browser$Debugger$Metadata$encodeUnion = function (_v0) {
	var args = _v0.args;
	var tags = _v0.tags;
	return $elm$json$Json$Encode$object(
		_List_fromArray(
			[
				_Utils_Tuple2(
				'args',
				A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, args)),
				_Utils_Tuple2(
				'tags',
				A2(
					$elm$browser$Debugger$Metadata$encodeDict,
					$elm$json$Json$Encode$list($elm$json$Json$Encode$string),
					tags))
			]));
};
var $elm$browser$Debugger$Metadata$encodeTypes = function (_v0) {
	var message = _v0.message;
	var unions = _v0.unions;
	var aliases = _v0.aliases;
	return $elm$json$Json$Encode$object(
		_List_fromArray(
			[
				_Utils_Tuple2(
				'message',
				$elm$json$Json$Encode$string(message)),
				_Utils_Tuple2(
				'aliases',
				A2($elm$browser$Debugger$Metadata$encodeDict, $elm$browser$Debugger$Metadata$encodeAlias, aliases)),
				_Utils_Tuple2(
				'unions',
				A2($elm$browser$Debugger$Metadata$encodeDict, $elm$browser$Debugger$Metadata$encodeUnion, unions))
			]));
};
var $elm$browser$Debugger$Metadata$encodeVersions = function (_v0) {
	var elm = _v0.elm;
	return $elm$json$Json$Encode$object(
		_List_fromArray(
			[
				_Utils_Tuple2(
				'elm',
				$elm$json$Json$Encode$string(elm))
			]));
};
var $elm$browser$Debugger$Metadata$encode = function (_v0) {
	var versions = _v0.versions;
	var types = _v0.types;
	return $elm$json$Json$Encode$object(
		_List_fromArray(
			[
				_Utils_Tuple2(
				'versions',
				$elm$browser$Debugger$Metadata$encodeVersions(versions)),
				_Utils_Tuple2(
				'types',
				$elm$browser$Debugger$Metadata$encodeTypes(types))
			]));
};
var $elm$core$Basics$identity = function (x) {
	return x;
};
var $elm$core$Task$Perform = function (a) {
	return {$: 'Perform', a: a};
};
var $elm$core$Task$succeed = _Scheduler_succeed;
var $elm$core$Task$init = $elm$core$Task$succeed(_Utils_Tuple0);
var $elm$core$Task$andThen = _Scheduler_andThen;
var $elm$core$Task$map = F2(
	function (func, taskA) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return $elm$core$Task$succeed(
					func(a));
			},
			taskA);
	});
var $elm$core$Task$map2 = F3(
	function (func, taskA, taskB) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return A2(
					$elm$core$Task$andThen,
					function (b) {
						return $elm$core$Task$succeed(
							A2(func, a, b));
					},
					taskB);
			},
			taskA);
	});
var $elm$core$Task$sequence = function (tasks) {
	return A3(
		$elm$core$List$foldr,
		$elm$core$Task$map2($elm$core$List$cons),
		$elm$core$Task$succeed(_List_Nil),
		tasks);
};
var $elm$core$Platform$sendToApp = _Platform_sendToApp;
var $elm$core$Task$spawnCmd = F2(
	function (router, _v0) {
		var task = _v0.a;
		return _Scheduler_spawn(
			A2(
				$elm$core$Task$andThen,
				$elm$core$Platform$sendToApp(router),
				task));
	});
var $elm$core$Task$onEffects = F3(
	function (router, commands, state) {
		return A2(
			$elm$core$Task$map,
			function (_v0) {
				return _Utils_Tuple0;
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Task$spawnCmd(router),
					commands)));
	});
var $elm$core$Task$onSelfMsg = F3(
	function (_v0, _v1, _v2) {
		return $elm$core$Task$succeed(_Utils_Tuple0);
	});
var $elm$core$Task$cmdMap = F2(
	function (tagger, _v0) {
		var task = _v0.a;
		return $elm$core$Task$Perform(
			A2($elm$core$Task$map, tagger, task));
	});
_Platform_effectManagers['Task'] = _Platform_createManager($elm$core$Task$init, $elm$core$Task$onEffects, $elm$core$Task$onSelfMsg, $elm$core$Task$cmdMap);
var $elm$core$Task$command = _Platform_leaf('Task');
var $elm$core$Task$perform = F2(
	function (toMessage, task) {
		return $elm$core$Task$command(
			$elm$core$Task$Perform(
				A2($elm$core$Task$map, toMessage, task)));
	});
var $elm$browser$Debugger$Main$download = F2(
	function (metadata, history) {
		var historyLength = $elm$browser$Debugger$History$size(history);
		return A2(
			$elm$core$Task$perform,
			function (_v0) {
				return $elm$browser$Debugger$Main$NoOp;
			},
			A2(
				_Debugger_download,
				historyLength,
				_Json_unwrap(
					$elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'metadata',
								$elm$browser$Debugger$Metadata$encode(metadata)),
								_Utils_Tuple2(
								'history',
								$elm$browser$Debugger$History$encode(history))
							])))));
	});
var $elm$browser$Debugger$Main$Vertical = F3(
	function (a, b, c) {
		return {$: 'Vertical', a: a, b: b, c: c};
	});
var $elm$browser$Debugger$Main$drag = F2(
	function (info, layout) {
		if (layout.$ === 'Horizontal') {
			var status = layout.a;
			var y = layout.c;
			return A3($elm$browser$Debugger$Main$Horizontal, status, info.x / info.width, y);
		} else {
			var status = layout.a;
			var x = layout.b;
			return A3($elm$browser$Debugger$Main$Vertical, status, x, info.y / info.height);
		}
	});
var $elm$browser$Debugger$History$Stepping = F2(
	function (a, b) {
		return {$: 'Stepping', a: a, b: b};
	});
var $elm$browser$Debugger$History$Done = F2(
	function (a, b) {
		return {$: 'Done', a: a, b: b};
	});
var $elm$browser$Debugger$History$getHelp = F3(
	function (update, msg, getResult) {
		if (getResult.$ === 'Done') {
			return getResult;
		} else {
			var n = getResult.a;
			var model = getResult.b;
			return (!n) ? A2(
				$elm$browser$Debugger$History$Done,
				msg,
				A2(update, msg, model).a) : A2(
				$elm$browser$Debugger$History$Stepping,
				n - 1,
				A2(update, msg, model).a);
		}
	});
var $elm$browser$Debugger$History$undone = function (getResult) {
	undone:
	while (true) {
		if (getResult.$ === 'Done') {
			var msg = getResult.a;
			var model = getResult.b;
			return _Utils_Tuple2(model, msg);
		} else {
			var $temp$getResult = getResult;
			getResult = $temp$getResult;
			continue undone;
		}
	}
};
var $elm$browser$Debugger$History$get = F3(
	function (update, index, history) {
		get:
		while (true) {
			var recent = history.recent;
			var snapshotMax = history.numMessages - recent.numMessages;
			if (_Utils_cmp(index, snapshotMax) > -1) {
				return $elm$browser$Debugger$History$undone(
					A3(
						$elm$core$List$foldr,
						$elm$browser$Debugger$History$getHelp(update),
						A2($elm$browser$Debugger$History$Stepping, index - snapshotMax, recent.model),
						recent.messages));
			} else {
				var _v0 = A2($elm$core$Array$get, (index / $elm$browser$Debugger$History$maxSnapshotSize) | 0, history.snapshots);
				if (_v0.$ === 'Nothing') {
					var $temp$update = update,
						$temp$index = index,
						$temp$history = history;
					update = $temp$update;
					index = $temp$index;
					history = $temp$history;
					continue get;
				} else {
					var model = _v0.a.model;
					var messages = _v0.a.messages;
					return $elm$browser$Debugger$History$undone(
						A3(
							$elm$core$Array$foldr,
							$elm$browser$Debugger$History$getHelp(update),
							A2($elm$browser$Debugger$History$Stepping, index % $elm$browser$Debugger$History$maxSnapshotSize, model),
							messages));
				}
			}
		}
	});
var $elm$browser$Debugger$History$getRecentMsg = function (history) {
	getRecentMsg:
	while (true) {
		var _v0 = history.recent.messages;
		if (!_v0.b) {
			var $temp$history = history;
			history = $temp$history;
			continue getRecentMsg;
		} else {
			var first = _v0.a;
			return first;
		}
	}
};
var $elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return $elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _v1 = A2($elm$core$Basics$compare, targetKey, key);
				switch (_v1.$) {
					case 'LT':
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 'EQ':
						return $elm$core$Maybe$Just(value);
					default:
						var $temp$targetKey = targetKey,
							$temp$dict = right;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
				}
			}
		}
	});
var $elm$browser$Debugger$Expando$mergeDictHelp = F3(
	function (oldDict, key, value) {
		var _v12 = A2($elm$core$Dict$get, key, oldDict);
		if (_v12.$ === 'Nothing') {
			return value;
		} else {
			var oldValue = _v12.a;
			return A2($elm$browser$Debugger$Expando$mergeHelp, oldValue, value);
		}
	});
var $elm$browser$Debugger$Expando$mergeHelp = F2(
	function (old, _new) {
		var _v3 = _Utils_Tuple2(old, _new);
		_v3$6:
		while (true) {
			switch (_v3.b.$) {
				case 'S':
					return _new;
				case 'Primitive':
					return _new;
				case 'Sequence':
					if (_v3.a.$ === 'Sequence') {
						var _v4 = _v3.a;
						var isClosed = _v4.b;
						var oldValues = _v4.c;
						var _v5 = _v3.b;
						var seqType = _v5.a;
						var newValues = _v5.c;
						return A3(
							$elm$browser$Debugger$Expando$Sequence,
							seqType,
							isClosed,
							A2($elm$browser$Debugger$Expando$mergeListHelp, oldValues, newValues));
					} else {
						break _v3$6;
					}
				case 'Dictionary':
					if (_v3.a.$ === 'Dictionary') {
						var _v6 = _v3.a;
						var isClosed = _v6.a;
						var _v7 = _v3.b;
						var keyValuePairs = _v7.b;
						return A2($elm$browser$Debugger$Expando$Dictionary, isClosed, keyValuePairs);
					} else {
						break _v3$6;
					}
				case 'Record':
					if (_v3.a.$ === 'Record') {
						var _v8 = _v3.a;
						var isClosed = _v8.a;
						var oldDict = _v8.b;
						var _v9 = _v3.b;
						var newDict = _v9.b;
						return A2(
							$elm$browser$Debugger$Expando$Record,
							isClosed,
							A2(
								$elm$core$Dict$map,
								$elm$browser$Debugger$Expando$mergeDictHelp(oldDict),
								newDict));
					} else {
						break _v3$6;
					}
				default:
					if (_v3.a.$ === 'Constructor') {
						var _v10 = _v3.a;
						var isClosed = _v10.b;
						var oldValues = _v10.c;
						var _v11 = _v3.b;
						var maybeName = _v11.a;
						var newValues = _v11.c;
						return A3(
							$elm$browser$Debugger$Expando$Constructor,
							maybeName,
							isClosed,
							A2($elm$browser$Debugger$Expando$mergeListHelp, oldValues, newValues));
					} else {
						break _v3$6;
					}
			}
		}
		return _new;
	});
var $elm$browser$Debugger$Expando$mergeListHelp = F2(
	function (olds, news) {
		var _v0 = _Utils_Tuple2(olds, news);
		if (!_v0.a.b) {
			return news;
		} else {
			if (!_v0.b.b) {
				return news;
			} else {
				var _v1 = _v0.a;
				var x = _v1.a;
				var xs = _v1.b;
				var _v2 = _v0.b;
				var y = _v2.a;
				var ys = _v2.b;
				return A2(
					$elm$core$List$cons,
					A2($elm$browser$Debugger$Expando$mergeHelp, x, y),
					A2($elm$browser$Debugger$Expando$mergeListHelp, xs, ys));
			}
		}
	});
var $elm$browser$Debugger$Expando$merge = F2(
	function (value, expando) {
		return A2(
			$elm$browser$Debugger$Expando$mergeHelp,
			expando,
			_Debugger_init(value));
	});
var $elm$browser$Debugger$Main$jumpUpdate = F3(
	function (update, index, model) {
		var history = $elm$browser$Debugger$Main$cachedHistory(model);
		var currentMsg = $elm$browser$Debugger$History$getRecentMsg(history);
		var currentModel = $elm$browser$Debugger$Main$getLatestModel(model.state);
		var _v0 = A3($elm$browser$Debugger$History$get, update, index, history);
		var indexModel = _v0.a;
		var indexMsg = _v0.b;
		return _Utils_update(
			model,
			{
				expandoModel: A2($elm$browser$Debugger$Expando$merge, indexModel, model.expandoModel),
				expandoMsg: A2($elm$browser$Debugger$Expando$merge, indexMsg, model.expandoMsg),
				state: A5($elm$browser$Debugger$Main$Paused, index, indexModel, currentModel, currentMsg, history)
			});
	});
var $elm$browser$Debugger$History$jsToElm = A2($elm$core$Basics$composeR, _Json_unwrap, _Debugger_unsafeCoerce);
var $elm$browser$Debugger$History$decoder = F2(
	function (initialModel, update) {
		var addMessage = F2(
			function (rawMsg, _v0) {
				var model = _v0.a;
				var history = _v0.b;
				var msg = $elm$browser$Debugger$History$jsToElm(rawMsg);
				return _Utils_Tuple2(
					A2(update, msg, model),
					A3($elm$browser$Debugger$History$add, msg, model, history));
			});
		var updateModel = function (rawMsgs) {
			return A3(
				$elm$core$List$foldl,
				addMessage,
				_Utils_Tuple2(
					initialModel,
					$elm$browser$Debugger$History$empty(initialModel)),
				rawMsgs);
		};
		return A2(
			$elm$json$Json$Decode$map,
			updateModel,
			$elm$json$Json$Decode$list($elm$json$Json$Decode$value));
	});
var $elm$browser$Debugger$History$getInitialModel = function (_v0) {
	var snapshots = _v0.snapshots;
	var recent = _v0.recent;
	var _v1 = A2($elm$core$Array$get, 0, snapshots);
	if (_v1.$ === 'Just') {
		var model = _v1.a.model;
		return model;
	} else {
		return recent.model;
	}
};
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $elm$browser$Debugger$Main$loadNewHistory = F3(
	function (rawHistory, update, model) {
		var pureUserUpdate = F2(
			function (msg, userModel) {
				return A2(update, msg, userModel).a;
			});
		var initialUserModel = $elm$browser$Debugger$History$getInitialModel(model.history);
		var decoder = A2($elm$browser$Debugger$History$decoder, initialUserModel, pureUserUpdate);
		var _v0 = A2($elm$json$Json$Decode$decodeValue, decoder, rawHistory);
		if (_v0.$ === 'Err') {
			return _Utils_Tuple2(
				_Utils_update(
					model,
					{overlay: $elm$browser$Debugger$Overlay$corruptImport}),
				$elm$core$Platform$Cmd$none);
		} else {
			var _v1 = _v0.a;
			var latestUserModel = _v1.a;
			var newHistory = _v1.b;
			return _Utils_Tuple2(
				_Utils_update(
					model,
					{
						expandoModel: $elm$browser$Debugger$Expando$init(latestUserModel),
						expandoMsg: $elm$browser$Debugger$Expando$init(
							$elm$browser$Debugger$History$getRecentMsg(newHistory)),
						history: newHistory,
						overlay: $elm$browser$Debugger$Overlay$none,
						state: $elm$browser$Debugger$Main$Running(latestUserModel)
					}),
				$elm$core$Platform$Cmd$none);
		}
	});
var $elm$browser$Debugger$Main$scroll = function (popout) {
	return A2(
		$elm$core$Task$perform,
		$elm$core$Basics$always($elm$browser$Debugger$Main$NoOp),
		_Debugger_scroll(popout));
};
var $elm$browser$Debugger$Main$scrollTo = F2(
	function (id, popout) {
		return A2(
			$elm$core$Task$perform,
			$elm$core$Basics$always($elm$browser$Debugger$Main$NoOp),
			A2(_Debugger_scrollTo, id, popout));
	});
var $elm$browser$Debugger$Main$setDragStatus = F2(
	function (status, layout) {
		if (layout.$ === 'Horizontal') {
			var x = layout.b;
			var y = layout.c;
			return A3($elm$browser$Debugger$Main$Horizontal, status, x, y);
		} else {
			var x = layout.b;
			var y = layout.c;
			return A3($elm$browser$Debugger$Main$Vertical, status, x, y);
		}
	});
var $elm$browser$Debugger$Main$swapLayout = function (layout) {
	if (layout.$ === 'Horizontal') {
		var s = layout.a;
		var x = layout.b;
		var y = layout.c;
		return A3($elm$browser$Debugger$Main$Vertical, s, x, y);
	} else {
		var s = layout.a;
		var x = layout.b;
		var y = layout.c;
		return A3($elm$browser$Debugger$Main$Horizontal, s, x, y);
	}
};
var $elm$core$Dict$getMin = function (dict) {
	getMin:
	while (true) {
		if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
			var left = dict.d;
			var $temp$dict = left;
			dict = $temp$dict;
			continue getMin;
		} else {
			return dict;
		}
	}
};
var $elm$core$Dict$moveRedLeft = function (dict) {
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.e.d.$ === 'RBNode_elm_builtin') && (dict.e.d.a.$ === 'Red')) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var lLeft = _v1.d;
			var lRight = _v1.e;
			var _v2 = dict.e;
			var rClr = _v2.a;
			var rK = _v2.b;
			var rV = _v2.c;
			var rLeft = _v2.d;
			var _v3 = rLeft.a;
			var rlK = rLeft.b;
			var rlV = rLeft.c;
			var rlL = rLeft.d;
			var rlR = rLeft.e;
			var rRight = _v2.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				$elm$core$Dict$Red,
				rlK,
				rlV,
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					rlL),
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rlR, rRight));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v4 = dict.d;
			var lClr = _v4.a;
			var lK = _v4.b;
			var lV = _v4.c;
			var lLeft = _v4.d;
			var lRight = _v4.e;
			var _v5 = dict.e;
			var rClr = _v5.a;
			var rK = _v5.b;
			var rV = _v5.c;
			var rLeft = _v5.d;
			var rRight = _v5.e;
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$moveRedRight = function (dict) {
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.d.d.$ === 'RBNode_elm_builtin') && (dict.d.d.a.$ === 'Red')) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var _v2 = _v1.d;
			var _v3 = _v2.a;
			var llK = _v2.b;
			var llV = _v2.c;
			var llLeft = _v2.d;
			var llRight = _v2.e;
			var lRight = _v1.e;
			var _v4 = dict.e;
			var rClr = _v4.a;
			var rK = _v4.b;
			var rV = _v4.c;
			var rLeft = _v4.d;
			var rRight = _v4.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				$elm$core$Dict$Red,
				lK,
				lV,
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					lRight,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight)));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v5 = dict.d;
			var lClr = _v5.a;
			var lK = _v5.b;
			var lV = _v5.c;
			var lLeft = _v5.d;
			var lRight = _v5.e;
			var _v6 = dict.e;
			var rClr = _v6.a;
			var rK = _v6.b;
			var rV = _v6.c;
			var rLeft = _v6.d;
			var rRight = _v6.e;
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$removeHelpPrepEQGT = F7(
	function (targetKey, dict, color, key, value, left, right) {
		if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
			var _v1 = left.a;
			var lK = left.b;
			var lV = left.c;
			var lLeft = left.d;
			var lRight = left.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				lK,
				lV,
				lLeft,
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, lRight, right));
		} else {
			_v2$2:
			while (true) {
				if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Black')) {
					if (right.d.$ === 'RBNode_elm_builtin') {
						if (right.d.a.$ === 'Black') {
							var _v3 = right.a;
							var _v4 = right.d;
							var _v5 = _v4.a;
							return $elm$core$Dict$moveRedRight(dict);
						} else {
							break _v2$2;
						}
					} else {
						var _v6 = right.a;
						var _v7 = right.d;
						return $elm$core$Dict$moveRedRight(dict);
					}
				} else {
					break _v2$2;
				}
			}
			return dict;
		}
	});
var $elm$core$Dict$removeMin = function (dict) {
	if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
		var color = dict.a;
		var key = dict.b;
		var value = dict.c;
		var left = dict.d;
		var lColor = left.a;
		var lLeft = left.d;
		var right = dict.e;
		if (lColor.$ === 'Black') {
			if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
				var _v3 = lLeft.a;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					key,
					value,
					$elm$core$Dict$removeMin(left),
					right);
			} else {
				var _v4 = $elm$core$Dict$moveRedLeft(dict);
				if (_v4.$ === 'RBNode_elm_builtin') {
					var nColor = _v4.a;
					var nKey = _v4.b;
					var nValue = _v4.c;
					var nLeft = _v4.d;
					var nRight = _v4.e;
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						$elm$core$Dict$removeMin(nLeft),
						nRight);
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			}
		} else {
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				key,
				value,
				$elm$core$Dict$removeMin(left),
				right);
		}
	} else {
		return $elm$core$Dict$RBEmpty_elm_builtin;
	}
};
var $elm$core$Dict$removeHelp = F2(
	function (targetKey, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		} else {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_cmp(targetKey, key) < 0) {
				if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Black')) {
					var _v4 = left.a;
					var lLeft = left.d;
					if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
						var _v6 = lLeft.a;
						return A5(
							$elm$core$Dict$RBNode_elm_builtin,
							color,
							key,
							value,
							A2($elm$core$Dict$removeHelp, targetKey, left),
							right);
					} else {
						var _v7 = $elm$core$Dict$moveRedLeft(dict);
						if (_v7.$ === 'RBNode_elm_builtin') {
							var nColor = _v7.a;
							var nKey = _v7.b;
							var nValue = _v7.c;
							var nLeft = _v7.d;
							var nRight = _v7.e;
							return A5(
								$elm$core$Dict$balance,
								nColor,
								nKey,
								nValue,
								A2($elm$core$Dict$removeHelp, targetKey, nLeft),
								nRight);
						} else {
							return $elm$core$Dict$RBEmpty_elm_builtin;
						}
					}
				} else {
					return A5(
						$elm$core$Dict$RBNode_elm_builtin,
						color,
						key,
						value,
						A2($elm$core$Dict$removeHelp, targetKey, left),
						right);
				}
			} else {
				return A2(
					$elm$core$Dict$removeHelpEQGT,
					targetKey,
					A7($elm$core$Dict$removeHelpPrepEQGT, targetKey, dict, color, key, value, left, right));
			}
		}
	});
var $elm$core$Dict$removeHelpEQGT = F2(
	function (targetKey, dict) {
		if (dict.$ === 'RBNode_elm_builtin') {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_eq(targetKey, key)) {
				var _v1 = $elm$core$Dict$getMin(right);
				if (_v1.$ === 'RBNode_elm_builtin') {
					var minKey = _v1.b;
					var minValue = _v1.c;
					return A5(
						$elm$core$Dict$balance,
						color,
						minKey,
						minValue,
						left,
						$elm$core$Dict$removeMin(right));
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			} else {
				return A5(
					$elm$core$Dict$balance,
					color,
					key,
					value,
					left,
					A2($elm$core$Dict$removeHelp, targetKey, right));
			}
		} else {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		}
	});
var $elm$core$Dict$remove = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$removeHelp, key, dict);
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $elm$core$Dict$update = F3(
	function (targetKey, alter, dictionary) {
		var _v0 = alter(
			A2($elm$core$Dict$get, targetKey, dictionary));
		if (_v0.$ === 'Just') {
			var value = _v0.a;
			return A3($elm$core$Dict$insert, targetKey, value, dictionary);
		} else {
			return A2($elm$core$Dict$remove, targetKey, dictionary);
		}
	});
var $elm$browser$Debugger$Expando$updateIndex = F3(
	function (n, func, list) {
		if (!list.b) {
			return _List_Nil;
		} else {
			var x = list.a;
			var xs = list.b;
			return (n <= 0) ? A2(
				$elm$core$List$cons,
				func(x),
				xs) : A2(
				$elm$core$List$cons,
				x,
				A3($elm$browser$Debugger$Expando$updateIndex, n - 1, func, xs));
		}
	});
var $elm$browser$Debugger$Expando$update = F2(
	function (msg, value) {
		switch (value.$) {
			case 'S':
				return value;
			case 'Primitive':
				return value;
			case 'Sequence':
				var seqType = value.a;
				var isClosed = value.b;
				var valueList = value.c;
				switch (msg.$) {
					case 'Toggle':
						return A3($elm$browser$Debugger$Expando$Sequence, seqType, !isClosed, valueList);
					case 'Index':
						if (msg.a.$ === 'None') {
							var _v3 = msg.a;
							var index = msg.b;
							var subMsg = msg.c;
							return A3(
								$elm$browser$Debugger$Expando$Sequence,
								seqType,
								isClosed,
								A3(
									$elm$browser$Debugger$Expando$updateIndex,
									index,
									$elm$browser$Debugger$Expando$update(subMsg),
									valueList));
						} else {
							return value;
						}
					default:
						return value;
				}
			case 'Dictionary':
				var isClosed = value.a;
				var keyValuePairs = value.b;
				switch (msg.$) {
					case 'Toggle':
						return A2($elm$browser$Debugger$Expando$Dictionary, !isClosed, keyValuePairs);
					case 'Index':
						var redirect = msg.a;
						var index = msg.b;
						var subMsg = msg.c;
						switch (redirect.$) {
							case 'None':
								return value;
							case 'Key':
								return A2(
									$elm$browser$Debugger$Expando$Dictionary,
									isClosed,
									A3(
										$elm$browser$Debugger$Expando$updateIndex,
										index,
										function (_v6) {
											var k = _v6.a;
											var v = _v6.b;
											return _Utils_Tuple2(
												A2($elm$browser$Debugger$Expando$update, subMsg, k),
												v);
										},
										keyValuePairs));
							default:
								return A2(
									$elm$browser$Debugger$Expando$Dictionary,
									isClosed,
									A3(
										$elm$browser$Debugger$Expando$updateIndex,
										index,
										function (_v7) {
											var k = _v7.a;
											var v = _v7.b;
											return _Utils_Tuple2(
												k,
												A2($elm$browser$Debugger$Expando$update, subMsg, v));
										},
										keyValuePairs));
						}
					default:
						return value;
				}
			case 'Record':
				var isClosed = value.a;
				var valueDict = value.b;
				switch (msg.$) {
					case 'Toggle':
						return A2($elm$browser$Debugger$Expando$Record, !isClosed, valueDict);
					case 'Index':
						return value;
					default:
						var field = msg.a;
						var subMsg = msg.b;
						return A2(
							$elm$browser$Debugger$Expando$Record,
							isClosed,
							A3(
								$elm$core$Dict$update,
								field,
								$elm$browser$Debugger$Expando$updateField(subMsg),
								valueDict));
				}
			default:
				var maybeName = value.a;
				var isClosed = value.b;
				var valueList = value.c;
				switch (msg.$) {
					case 'Toggle':
						return A3($elm$browser$Debugger$Expando$Constructor, maybeName, !isClosed, valueList);
					case 'Index':
						if (msg.a.$ === 'None') {
							var _v10 = msg.a;
							var index = msg.b;
							var subMsg = msg.c;
							return A3(
								$elm$browser$Debugger$Expando$Constructor,
								maybeName,
								isClosed,
								A3(
									$elm$browser$Debugger$Expando$updateIndex,
									index,
									$elm$browser$Debugger$Expando$update(subMsg),
									valueList));
						} else {
							return value;
						}
					default:
						return value;
				}
		}
	});
var $elm$browser$Debugger$Expando$updateField = F2(
	function (msg, maybeExpando) {
		if (maybeExpando.$ === 'Nothing') {
			return maybeExpando;
		} else {
			var expando = maybeExpando.a;
			return $elm$core$Maybe$Just(
				A2($elm$browser$Debugger$Expando$update, msg, expando));
		}
	});
var $elm$browser$Debugger$Main$Upload = function (a) {
	return {$: 'Upload', a: a};
};
var $elm$browser$Debugger$Main$upload = function (popout) {
	return A2(
		$elm$core$Task$perform,
		$elm$browser$Debugger$Main$Upload,
		_Debugger_upload(popout));
};
var $elm$browser$Debugger$Overlay$BadMetadata = function (a) {
	return {$: 'BadMetadata', a: a};
};
var $elm$browser$Debugger$Overlay$badMetadata = $elm$browser$Debugger$Overlay$BadMetadata;
var $elm$browser$Debugger$Main$withGoodMetadata = F2(
	function (model, func) {
		var _v0 = model.metadata;
		if (_v0.$ === 'Ok') {
			var metadata = _v0.a;
			return func(metadata);
		} else {
			var error = _v0.a;
			return _Utils_Tuple2(
				_Utils_update(
					model,
					{
						overlay: $elm$browser$Debugger$Overlay$badMetadata(error)
					}),
				$elm$core$Platform$Cmd$none);
		}
	});
var $elm$browser$Debugger$Main$wrapUpdate = F3(
	function (update, msg, model) {
		wrapUpdate:
		while (true) {
			switch (msg.$) {
				case 'NoOp':
					return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
				case 'UserMsg':
					var userMsg = msg.a;
					var userModel = $elm$browser$Debugger$Main$getLatestModel(model.state);
					var newHistory = A3($elm$browser$Debugger$History$add, userMsg, userModel, model.history);
					var _v1 = A2(update, userMsg, userModel);
					var newUserModel = _v1.a;
					var userCmds = _v1.b;
					var commands = A2($elm$core$Platform$Cmd$map, $elm$browser$Debugger$Main$UserMsg, userCmds);
					var _v2 = model.state;
					if (_v2.$ === 'Running') {
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{
									expandoModel: A2($elm$browser$Debugger$Expando$merge, newUserModel, model.expandoModel),
									expandoMsg: A2($elm$browser$Debugger$Expando$merge, userMsg, model.expandoMsg),
									history: newHistory,
									state: $elm$browser$Debugger$Main$Running(newUserModel)
								}),
							$elm$core$Platform$Cmd$batch(
								_List_fromArray(
									[
										commands,
										$elm$browser$Debugger$Main$scroll(model.popout)
									])));
					} else {
						var index = _v2.a;
						var indexModel = _v2.b;
						var history = _v2.e;
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{
									history: newHistory,
									state: A5($elm$browser$Debugger$Main$Paused, index, indexModel, newUserModel, userMsg, history)
								}),
							commands);
					}
				case 'TweakExpandoMsg':
					var eMsg = msg.a;
					return _Utils_Tuple2(
						_Utils_update(
							model,
							{
								expandoMsg: A2($elm$browser$Debugger$Expando$update, eMsg, model.expandoMsg)
							}),
						$elm$core$Platform$Cmd$none);
				case 'TweakExpandoModel':
					var eMsg = msg.a;
					return _Utils_Tuple2(
						_Utils_update(
							model,
							{
								expandoModel: A2($elm$browser$Debugger$Expando$update, eMsg, model.expandoModel)
							}),
						$elm$core$Platform$Cmd$none);
				case 'Resume':
					var _v3 = model.state;
					if (_v3.$ === 'Running') {
						return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
					} else {
						var userModel = _v3.c;
						var userMsg = _v3.d;
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{
									expandoModel: A2($elm$browser$Debugger$Expando$merge, userModel, model.expandoModel),
									expandoMsg: A2($elm$browser$Debugger$Expando$merge, userMsg, model.expandoMsg),
									state: $elm$browser$Debugger$Main$Running(userModel)
								}),
							$elm$browser$Debugger$Main$scroll(model.popout));
					}
				case 'Jump':
					var index = msg.a;
					return _Utils_Tuple2(
						A3($elm$browser$Debugger$Main$jumpUpdate, update, index, model),
						$elm$core$Platform$Cmd$none);
				case 'SliderJump':
					var index = msg.a;
					return _Utils_Tuple2(
						A3($elm$browser$Debugger$Main$jumpUpdate, update, index, model),
						A2(
							$elm$browser$Debugger$Main$scrollTo,
							$elm$browser$Debugger$History$idForMessageIndex(index),
							model.popout));
				case 'Open':
					return _Utils_Tuple2(
						model,
						A2(
							$elm$core$Task$perform,
							$elm$core$Basics$always($elm$browser$Debugger$Main$NoOp),
							_Debugger_open(model.popout)));
				case 'Up':
					var _v4 = model.state;
					if (_v4.$ === 'Running') {
						return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
					} else {
						var i = _v4.a;
						var history = _v4.e;
						var targetIndex = i + 1;
						if (_Utils_cmp(
							targetIndex,
							$elm$browser$Debugger$History$size(history)) < 0) {
							var $temp$update = update,
								$temp$msg = $elm$browser$Debugger$Main$SliderJump(targetIndex),
								$temp$model = model;
							update = $temp$update;
							msg = $temp$msg;
							model = $temp$model;
							continue wrapUpdate;
						} else {
							var $temp$update = update,
								$temp$msg = $elm$browser$Debugger$Main$Resume,
								$temp$model = model;
							update = $temp$update;
							msg = $temp$msg;
							model = $temp$model;
							continue wrapUpdate;
						}
					}
				case 'Down':
					var _v5 = model.state;
					if (_v5.$ === 'Running') {
						var $temp$update = update,
							$temp$msg = $elm$browser$Debugger$Main$Jump(
							$elm$browser$Debugger$History$size(model.history) - 1),
							$temp$model = model;
						update = $temp$update;
						msg = $temp$msg;
						model = $temp$model;
						continue wrapUpdate;
					} else {
						var index = _v5.a;
						if (index > 0) {
							var $temp$update = update,
								$temp$msg = $elm$browser$Debugger$Main$SliderJump(index - 1),
								$temp$model = model;
							update = $temp$update;
							msg = $temp$msg;
							model = $temp$model;
							continue wrapUpdate;
						} else {
							return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
						}
					}
				case 'Import':
					return A2(
						$elm$browser$Debugger$Main$withGoodMetadata,
						model,
						function (_v6) {
							return _Utils_Tuple2(
								model,
								$elm$browser$Debugger$Main$upload(model.popout));
						});
				case 'Export':
					return A2(
						$elm$browser$Debugger$Main$withGoodMetadata,
						model,
						function (metadata) {
							return _Utils_Tuple2(
								model,
								A2($elm$browser$Debugger$Main$download, metadata, model.history));
						});
				case 'Upload':
					var jsonString = msg.a;
					return A2(
						$elm$browser$Debugger$Main$withGoodMetadata,
						model,
						function (metadata) {
							var _v7 = A2($elm$browser$Debugger$Overlay$assessImport, metadata, jsonString);
							if (_v7.$ === 'Err') {
								var newOverlay = _v7.a;
								return _Utils_Tuple2(
									_Utils_update(
										model,
										{overlay: newOverlay}),
									$elm$core$Platform$Cmd$none);
							} else {
								var rawHistory = _v7.a;
								return A3($elm$browser$Debugger$Main$loadNewHistory, rawHistory, update, model);
							}
						});
				case 'OverlayMsg':
					var overlayMsg = msg.a;
					var _v8 = A2($elm$browser$Debugger$Overlay$close, overlayMsg, model.overlay);
					if (_v8.$ === 'Nothing') {
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{overlay: $elm$browser$Debugger$Overlay$none}),
							$elm$core$Platform$Cmd$none);
					} else {
						var rawHistory = _v8.a;
						return A3($elm$browser$Debugger$Main$loadNewHistory, rawHistory, update, model);
					}
				case 'SwapLayout':
					return _Utils_Tuple2(
						_Utils_update(
							model,
							{
								layout: $elm$browser$Debugger$Main$swapLayout(model.layout)
							}),
						$elm$core$Platform$Cmd$none);
				case 'DragStart':
					return _Utils_Tuple2(
						_Utils_update(
							model,
							{
								layout: A2($elm$browser$Debugger$Main$setDragStatus, $elm$browser$Debugger$Main$Moving, model.layout)
							}),
						$elm$core$Platform$Cmd$none);
				case 'Drag':
					var info = msg.a;
					return _Utils_Tuple2(
						_Utils_update(
							model,
							{
								layout: A2($elm$browser$Debugger$Main$drag, info, model.layout)
							}),
						$elm$core$Platform$Cmd$none);
				default:
					return _Utils_Tuple2(
						_Utils_update(
							model,
							{
								layout: A2($elm$browser$Debugger$Main$setDragStatus, $elm$browser$Debugger$Main$Static, model.layout)
							}),
						$elm$core$Platform$Cmd$none);
			}
		}
	});
var $elm$browser$Browser$External = function (a) {
	return {$: 'External', a: a};
};
var $elm$browser$Browser$Internal = function (a) {
	return {$: 'Internal', a: a};
};
var $elm$browser$Browser$Dom$NotFound = function (a) {
	return {$: 'NotFound', a: a};
};
var $elm$url$Url$Http = {$: 'Http'};
var $elm$url$Url$Https = {$: 'Https'};
var $elm$url$Url$Url = F6(
	function (protocol, host, port_, path, query, fragment) {
		return {fragment: fragment, host: host, path: path, port_: port_, protocol: protocol, query: query};
	});
var $elm$core$String$dropLeft = F2(
	function (n, string) {
		return (n < 1) ? string : A3(
			$elm$core$String$slice,
			n,
			$elm$core$String$length(string),
			string);
	});
var $elm$core$String$indexes = _String_indexes;
var $elm$core$String$isEmpty = function (string) {
	return string === '';
};
var $elm$url$Url$chompBeforePath = F5(
	function (protocol, path, params, frag, str) {
		if ($elm$core$String$isEmpty(str) || A2($elm$core$String$contains, '@', str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, ':', str);
			if (!_v0.b) {
				return $elm$core$Maybe$Just(
					A6($elm$url$Url$Url, protocol, str, $elm$core$Maybe$Nothing, path, params, frag));
			} else {
				if (!_v0.b.b) {
					var i = _v0.a;
					var _v1 = $elm$core$String$toInt(
						A2($elm$core$String$dropLeft, i + 1, str));
					if (_v1.$ === 'Nothing') {
						return $elm$core$Maybe$Nothing;
					} else {
						var port_ = _v1;
						return $elm$core$Maybe$Just(
							A6(
								$elm$url$Url$Url,
								protocol,
								A2($elm$core$String$left, i, str),
								port_,
								path,
								params,
								frag));
					}
				} else {
					return $elm$core$Maybe$Nothing;
				}
			}
		}
	});
var $elm$url$Url$chompBeforeQuery = F4(
	function (protocol, params, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '/', str);
			if (!_v0.b) {
				return A5($elm$url$Url$chompBeforePath, protocol, '/', params, frag, str);
			} else {
				var i = _v0.a;
				return A5(
					$elm$url$Url$chompBeforePath,
					protocol,
					A2($elm$core$String$dropLeft, i, str),
					params,
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompBeforeFragment = F3(
	function (protocol, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '?', str);
			if (!_v0.b) {
				return A4($elm$url$Url$chompBeforeQuery, protocol, $elm$core$Maybe$Nothing, frag, str);
			} else {
				var i = _v0.a;
				return A4(
					$elm$url$Url$chompBeforeQuery,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompAfterProtocol = F2(
	function (protocol, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '#', str);
			if (!_v0.b) {
				return A3($elm$url$Url$chompBeforeFragment, protocol, $elm$core$Maybe$Nothing, str);
			} else {
				var i = _v0.a;
				return A3(
					$elm$url$Url$chompBeforeFragment,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$core$String$startsWith = _String_startsWith;
var $elm$url$Url$fromString = function (str) {
	return A2($elm$core$String$startsWith, 'http://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Http,
		A2($elm$core$String$dropLeft, 7, str)) : (A2($elm$core$String$startsWith, 'https://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Https,
		A2($elm$core$String$dropLeft, 8, str)) : $elm$core$Maybe$Nothing);
};
var $elm$core$Basics$never = function (_v0) {
	never:
	while (true) {
		var nvr = _v0.a;
		var $temp$_v0 = nvr;
		_v0 = $temp$_v0;
		continue never;
	}
};
var $elm$browser$Browser$application = _Browser_application;
var $author$project$Main$Model = F2(
	function (shared, page) {
		return {page: page, shared: shared};
	});
var $author$project$Main$Pages = function (a) {
	return {$: 'Pages', a: a};
};
var $author$project$Main$Shared = function (a) {
	return {$: 'Shared', a: a};
};
var $author$project$Spa$Generated$Route$NotFound = {$: 'NotFound'};
var $elm$url$Url$Parser$State = F5(
	function (visited, unvisited, params, frag, value) {
		return {frag: frag, params: params, unvisited: unvisited, value: value, visited: visited};
	});
var $elm$url$Url$Parser$getFirstMatch = function (states) {
	getFirstMatch:
	while (true) {
		if (!states.b) {
			return $elm$core$Maybe$Nothing;
		} else {
			var state = states.a;
			var rest = states.b;
			var _v1 = state.unvisited;
			if (!_v1.b) {
				return $elm$core$Maybe$Just(state.value);
			} else {
				if ((_v1.a === '') && (!_v1.b.b)) {
					return $elm$core$Maybe$Just(state.value);
				} else {
					var $temp$states = rest;
					states = $temp$states;
					continue getFirstMatch;
				}
			}
		}
	}
};
var $elm$url$Url$Parser$removeFinalEmpty = function (segments) {
	if (!segments.b) {
		return _List_Nil;
	} else {
		if ((segments.a === '') && (!segments.b.b)) {
			return _List_Nil;
		} else {
			var segment = segments.a;
			var rest = segments.b;
			return A2(
				$elm$core$List$cons,
				segment,
				$elm$url$Url$Parser$removeFinalEmpty(rest));
		}
	}
};
var $elm$url$Url$Parser$preparePath = function (path) {
	var _v0 = A2($elm$core$String$split, '/', path);
	if (_v0.b && (_v0.a === '')) {
		var segments = _v0.b;
		return $elm$url$Url$Parser$removeFinalEmpty(segments);
	} else {
		var segments = _v0;
		return $elm$url$Url$Parser$removeFinalEmpty(segments);
	}
};
var $elm$url$Url$Parser$addToParametersHelp = F2(
	function (value, maybeList) {
		if (maybeList.$ === 'Nothing') {
			return $elm$core$Maybe$Just(
				_List_fromArray(
					[value]));
		} else {
			var list = maybeList.a;
			return $elm$core$Maybe$Just(
				A2($elm$core$List$cons, value, list));
		}
	});
var $elm$url$Url$percentDecode = _Url_percentDecode;
var $elm$url$Url$Parser$addParam = F2(
	function (segment, dict) {
		var _v0 = A2($elm$core$String$split, '=', segment);
		if ((_v0.b && _v0.b.b) && (!_v0.b.b.b)) {
			var rawKey = _v0.a;
			var _v1 = _v0.b;
			var rawValue = _v1.a;
			var _v2 = $elm$url$Url$percentDecode(rawKey);
			if (_v2.$ === 'Nothing') {
				return dict;
			} else {
				var key = _v2.a;
				var _v3 = $elm$url$Url$percentDecode(rawValue);
				if (_v3.$ === 'Nothing') {
					return dict;
				} else {
					var value = _v3.a;
					return A3(
						$elm$core$Dict$update,
						key,
						$elm$url$Url$Parser$addToParametersHelp(value),
						dict);
				}
			}
		} else {
			return dict;
		}
	});
var $elm$url$Url$Parser$prepareQuery = function (maybeQuery) {
	if (maybeQuery.$ === 'Nothing') {
		return $elm$core$Dict$empty;
	} else {
		var qry = maybeQuery.a;
		return A3(
			$elm$core$List$foldr,
			$elm$url$Url$Parser$addParam,
			$elm$core$Dict$empty,
			A2($elm$core$String$split, '&', qry));
	}
};
var $elm$url$Url$Parser$parse = F2(
	function (_v0, url) {
		var parser = _v0.a;
		return $elm$url$Url$Parser$getFirstMatch(
			parser(
				A5(
					$elm$url$Url$Parser$State,
					_List_Nil,
					$elm$url$Url$Parser$preparePath(url.path),
					$elm$url$Url$Parser$prepareQuery(url.query),
					url.fragment,
					$elm$core$Basics$identity)));
	});
var $author$project$Spa$Generated$Route$Addons = {$: 'Addons'};
var $author$project$Spa$Generated$Route$Browser = {$: 'Browser'};
var $author$project$Spa$Generated$Route$Browser__Source_String = function (a) {
	return {$: 'Browser__Source_String', a: a};
};
var $author$project$Spa$Generated$Route$Help = {$: 'Help'};
var $author$project$Spa$Generated$Route$Lab = {$: 'Lab'};
var $author$project$Spa$Generated$Route$Movies = {$: 'Movies'};
var $author$project$Spa$Generated$Route$Movies__Recent = {$: 'Movies__Recent'};
var $author$project$Spa$Generated$Route$Music = {$: 'Music'};
var $author$project$Spa$Generated$Route$Music__Album__Albumid_Int = function (a) {
	return {$: 'Music__Album__Albumid_Int', a: a};
};
var $author$project$Spa$Generated$Route$Music__Albums = {$: 'Music__Albums'};
var $author$project$Spa$Generated$Route$Music__Artist__Artistid_Int = function (a) {
	return {$: 'Music__Artist__Artistid_Int', a: a};
};
var $author$project$Spa$Generated$Route$Music__Artists = {$: 'Music__Artists'};
var $author$project$Spa$Generated$Route$Music__Genre__Genre_String = function (a) {
	return {$: 'Music__Genre__Genre_String', a: a};
};
var $author$project$Spa$Generated$Route$Music__Genres = {$: 'Music__Genres'};
var $author$project$Spa$Generated$Route$Music__Top__Top = {$: 'Music__Top__Top'};
var $author$project$Spa$Generated$Route$Music__Videos = {$: 'Music__Videos'};
var $author$project$Spa$Generated$Route$Playlists = {$: 'Playlists'};
var $author$project$Spa$Generated$Route$Playlists__Name_String = function (a) {
	return {$: 'Playlists__Name_String', a: a};
};
var $author$project$Spa$Generated$Route$Settings__Addons = {$: 'Settings__Addons'};
var $author$project$Spa$Generated$Route$Settings__Kodi__Games = {$: 'Settings__Kodi__Games'};
var $author$project$Spa$Generated$Route$Settings__Kodi__Interface = {$: 'Settings__Kodi__Interface'};
var $author$project$Spa$Generated$Route$Settings__Kodi__Media = {$: 'Settings__Kodi__Media'};
var $author$project$Spa$Generated$Route$Settings__Kodi__Player = {$: 'Settings__Kodi__Player'};
var $author$project$Spa$Generated$Route$Settings__Kodi__Pvr = {$: 'Settings__Kodi__Pvr'};
var $author$project$Spa$Generated$Route$Settings__Kodi__Services = {$: 'Settings__Kodi__Services'};
var $author$project$Spa$Generated$Route$Settings__Kodi__System = {$: 'Settings__Kodi__System'};
var $author$project$Spa$Generated$Route$Settings__Nav = {$: 'Settings__Nav'};
var $author$project$Spa$Generated$Route$Settings__Search = {$: 'Settings__Search'};
var $author$project$Spa$Generated$Route$Settings__Web = {$: 'Settings__Web'};
var $author$project$Spa$Generated$Route$Thumbsup = {$: 'Thumbsup'};
var $author$project$Spa$Generated$Route$Top = {$: 'Top'};
var $author$project$Spa$Generated$Route$Tvshows = {$: 'Tvshows'};
var $author$project$Spa$Generated$Route$Tvshows__Recent = {$: 'Tvshows__Recent'};
var $author$project$Spa$Generated$Route$Videoplayer__Movieid_Int = function (a) {
	return {$: 'Videoplayer__Movieid_Int', a: a};
};
var $elm$url$Url$Parser$Parser = function (a) {
	return {$: 'Parser', a: a};
};
var $elm$url$Url$Parser$custom = F2(
	function (tipe, stringToSomething) {
		return $elm$url$Url$Parser$Parser(
			function (_v0) {
				var visited = _v0.visited;
				var unvisited = _v0.unvisited;
				var params = _v0.params;
				var frag = _v0.frag;
				var value = _v0.value;
				if (!unvisited.b) {
					return _List_Nil;
				} else {
					var next = unvisited.a;
					var rest = unvisited.b;
					var _v2 = stringToSomething(next);
					if (_v2.$ === 'Just') {
						var nextValue = _v2.a;
						return _List_fromArray(
							[
								A5(
								$elm$url$Url$Parser$State,
								A2($elm$core$List$cons, next, visited),
								rest,
								params,
								frag,
								value(nextValue))
							]);
					} else {
						return _List_Nil;
					}
				}
			});
	});
var $elm$url$Url$Parser$int = A2($elm$url$Url$Parser$custom, 'NUMBER', $elm$core$String$toInt);
var $elm$url$Url$Parser$mapState = F2(
	function (func, _v0) {
		var visited = _v0.visited;
		var unvisited = _v0.unvisited;
		var params = _v0.params;
		var frag = _v0.frag;
		var value = _v0.value;
		return A5(
			$elm$url$Url$Parser$State,
			visited,
			unvisited,
			params,
			frag,
			func(value));
	});
var $elm$url$Url$Parser$map = F2(
	function (subValue, _v0) {
		var parseArg = _v0.a;
		return $elm$url$Url$Parser$Parser(
			function (_v1) {
				var visited = _v1.visited;
				var unvisited = _v1.unvisited;
				var params = _v1.params;
				var frag = _v1.frag;
				var value = _v1.value;
				return A2(
					$elm$core$List$map,
					$elm$url$Url$Parser$mapState(value),
					parseArg(
						A5($elm$url$Url$Parser$State, visited, unvisited, params, frag, subValue)));
			});
	});
var $elm$url$Url$Parser$oneOf = function (parsers) {
	return $elm$url$Url$Parser$Parser(
		function (state) {
			return A2(
				$elm$core$List$concatMap,
				function (_v0) {
					var parser = _v0.a;
					return parser(state);
				},
				parsers);
		});
};
var $elm$url$Url$Parser$s = function (str) {
	return $elm$url$Url$Parser$Parser(
		function (_v0) {
			var visited = _v0.visited;
			var unvisited = _v0.unvisited;
			var params = _v0.params;
			var frag = _v0.frag;
			var value = _v0.value;
			if (!unvisited.b) {
				return _List_Nil;
			} else {
				var next = unvisited.a;
				var rest = unvisited.b;
				return _Utils_eq(next, str) ? _List_fromArray(
					[
						A5(
						$elm$url$Url$Parser$State,
						A2($elm$core$List$cons, next, visited),
						rest,
						params,
						frag,
						value)
					]) : _List_Nil;
			}
		});
};
var $elm$url$Url$Parser$slash = F2(
	function (_v0, _v1) {
		var parseBefore = _v0.a;
		var parseAfter = _v1.a;
		return $elm$url$Url$Parser$Parser(
			function (state) {
				return A2(
					$elm$core$List$concatMap,
					parseAfter,
					parseBefore(state));
			});
	});
var $elm$url$Url$Parser$string = A2($elm$url$Url$Parser$custom, 'STRING', $elm$core$Maybe$Just);
var $elm$url$Url$Parser$top = $elm$url$Url$Parser$Parser(
	function (state) {
		return _List_fromArray(
			[state]);
	});
var $author$project$Spa$Generated$Route$routes = $elm$url$Url$Parser$oneOf(
	_List_fromArray(
		[
			A2($elm$url$Url$Parser$map, $author$project$Spa$Generated$Route$Top, $elm$url$Url$Parser$top),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Addons,
			$elm$url$Url$Parser$s('addons')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Browser,
			$elm$url$Url$Parser$s('browser')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Help,
			$elm$url$Url$Parser$s('help')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Lab,
			$elm$url$Url$Parser$s('lab')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Movies,
			$elm$url$Url$Parser$s('movies')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Music,
			$elm$url$Url$Parser$s('music')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$NotFound,
			$elm$url$Url$Parser$s('not-found')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Playlists,
			$elm$url$Url$Parser$s('playlists')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Thumbsup,
			$elm$url$Url$Parser$s('thumbsup')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Tvshows,
			$elm$url$Url$Parser$s('tvshows')),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Movies__Recent,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('movies'),
				$elm$url$Url$Parser$s('recent'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Music__Albums,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('music'),
				$elm$url$Url$Parser$s('albums'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Music__Artists,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('music'),
				$elm$url$Url$Parser$s('artists'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Music__Genres,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('music'),
				$elm$url$Url$Parser$s('genres'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Music__Videos,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('music'),
				$elm$url$Url$Parser$s('videos'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Addons,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				$elm$url$Url$Parser$s('addons'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Nav,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				$elm$url$Url$Parser$s('nav'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Search,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				$elm$url$Url$Parser$s('search'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Web,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				$elm$url$Url$Parser$s('web'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Tvshows__Recent,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('tvshows'),
				$elm$url$Url$Parser$s('recent'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Browser__Source_String,
			A2(
				$elm$url$Url$Parser$map,
				function (source) {
					return {source: source};
				},
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('browser'),
					$elm$url$Url$Parser$string))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Playlists__Name_String,
			A2(
				$elm$url$Url$Parser$map,
				function (name) {
					return {name: name};
				},
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('playlists'),
					$elm$url$Url$Parser$string))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Videoplayer__Movieid_Int,
			A2(
				$elm$url$Url$Parser$map,
				function (movieid) {
					return {movieid: movieid};
				},
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('videoplayer'),
					$elm$url$Url$Parser$int))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Music__Top__Top,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('music'),
				$elm$url$Url$Parser$s('top'))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Kodi__Games,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('kodi'),
					$elm$url$Url$Parser$s('games')))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Kodi__Interface,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('kodi'),
					$elm$url$Url$Parser$s('interface')))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Kodi__Media,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('kodi'),
					$elm$url$Url$Parser$s('media')))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Kodi__Player,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('kodi'),
					$elm$url$Url$Parser$s('player')))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Kodi__Pvr,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('kodi'),
					$elm$url$Url$Parser$s('pvr')))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Kodi__Services,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('kodi'),
					$elm$url$Url$Parser$s('services')))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Settings__Kodi__System,
			A2(
				$elm$url$Url$Parser$slash,
				$elm$url$Url$Parser$s('settings'),
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('kodi'),
					$elm$url$Url$Parser$s('system')))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Music__Album__Albumid_Int,
			A2(
				$elm$url$Url$Parser$map,
				function (albumid) {
					return {albumid: albumid};
				},
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('music'),
					A2(
						$elm$url$Url$Parser$slash,
						$elm$url$Url$Parser$s('album'),
						$elm$url$Url$Parser$int)))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Music__Artist__Artistid_Int,
			A2(
				$elm$url$Url$Parser$map,
				function (artistid) {
					return {artistid: artistid};
				},
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('music'),
					A2(
						$elm$url$Url$Parser$slash,
						$elm$url$Url$Parser$s('artist'),
						$elm$url$Url$Parser$int)))),
			A2(
			$elm$url$Url$Parser$map,
			$author$project$Spa$Generated$Route$Music__Genre__Genre_String,
			A2(
				$elm$url$Url$Parser$map,
				function (genre) {
					return {genre: genre};
				},
				A2(
					$elm$url$Url$Parser$slash,
					$elm$url$Url$Parser$s('music'),
					A2(
						$elm$url$Url$Parser$slash,
						$elm$url$Url$Parser$s('genre'),
						$elm$url$Url$Parser$string))))
		]));
var $author$project$Spa$Generated$Route$fromUrl = $elm$url$Url$Parser$parse($author$project$Spa$Generated$Route$routes);
var $author$project$Main$fromUrl = A2(
	$elm$core$Basics$composeR,
	$author$project$Spa$Generated$Route$fromUrl,
	$elm$core$Maybe$withDefault($author$project$Spa$Generated$Route$NotFound));
var $author$project$Components$LayoutType$None = {$: 'None'};
var $author$project$WSDecoder$NotAsked = {$: 'NotAsked'};
var $author$project$Shared$Off = {$: 'Off'};
var $author$project$Shared$ProgressSliderChange = function (a) {
	return {$: 'ProgressSliderChange', a: a};
};
var $author$project$Shared$VolumeSliderChange = function (a) {
	return {$: 'VolumeSliderChange', a: a};
};
var $carwow$elm_slider$SingleSlider$SingleSlider = function (a) {
	return {$: 'SingleSlider', a: a};
};
var $carwow$elm_slider$RangeSlider$defaultLabelFormatter = function (value) {
	return $elm$core$String$fromFloat(value);
};
var $carwow$elm_slider$RangeSlider$defaultValueFormatter = F2(
	function (value, max) {
		return _Utils_eq(value, max) ? '' : $elm$core$String$fromFloat(value);
	});
var $carwow$elm_slider$SingleSlider$init = function (attrs) {
	return $carwow$elm_slider$SingleSlider$SingleSlider(
		{
			commonAttributes: {max: attrs.max, maxFormatter: $carwow$elm_slider$RangeSlider$defaultLabelFormatter, min: attrs.min, minFormatter: $carwow$elm_slider$RangeSlider$defaultLabelFormatter, step: attrs.step},
			valueAttributes: {change: attrs.onChange, formatter: $carwow$elm_slider$RangeSlider$defaultValueFormatter, value: attrs.value}
		});
};
var $author$project$WSDecoder$LocalPlaylists = function (localPlaylists) {
	return {localPlaylists: localPlaylists};
};
var $author$project$WSDecoder$PlaylistObj = F2(
	function (name, songs) {
		return {name: name, songs: songs};
	});
var $NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom = $elm$json$Json$Decode$map2($elm$core$Basics$apR);
var $NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required = F3(
	function (key, valDecoder, decoder) {
		return A2(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
			A2($elm$json$Json$Decode$field, key, valDecoder),
			decoder);
	});
var $author$project$WSDecoder$playlistObjDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'songs',
	$elm$json$Json$Decode$list($elm$json$Json$Decode$int),
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'name',
		$elm$json$Json$Decode$string,
		$elm$json$Json$Decode$succeed($author$project$WSDecoder$PlaylistObj)));
var $author$project$WSDecoder$localPlaylistDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'localPlaylists',
	$elm$json$Json$Decode$list($author$project$WSDecoder$playlistObjDecoder),
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$LocalPlaylists));
var $author$project$Shared$sendActions = _Platform_outgoingPort(
	'sendActions',
	$elm$json$Json$Encode$list($elm$json$Json$Encode$string));
var $author$project$Shared$init = F3(
	function (flags, url, key) {
		var decodedlocalPlaylists = function () {
			var _v0 = flags.localPlaylists;
			if (_v0.$ === 'Nothing') {
				return {localPlaylists: _List_Nil};
			} else {
				var localPlaylists = _v0.a;
				var _v1 = A2($elm$json$Json$Decode$decodeString, $author$project$WSDecoder$localPlaylistDecoder, localPlaylists);
				if (_v1.$ === 'Ok') {
					var playlists = _v1.a;
					return playlists;
				} else {
					return {localPlaylists: _List_Nil};
				}
			}
		}();
		return _Utils_Tuple2(
			{
				album_list: _List_Nil,
				artist_list: _List_Nil,
				connection: $author$project$WSDecoder$NotAsked,
				controlMenu: false,
				currentlyPlaying: $elm$core$Maybe$Nothing,
				file_list: _List_Nil,
				flags: flags,
				genre_list: _List_Nil,
				key: key,
				movie_list: _List_Nil,
				players: _List_Nil,
				playing: false,
				playlistName: '',
				playlists: decodedlocalPlaylists,
				prepareDownloadPath: $elm$core$Maybe$Nothing,
				progressSlider: $carwow$elm_slider$SingleSlider$init(
					{max: 100, min: 0, onChange: $author$project$Shared$ProgressSliderChange, step: 1, value: 1}),
				repeat: $author$project$Shared$Off,
				rightSidebarExtended: false,
				searchString: '',
				showDialog: $author$project$Components$LayoutType$None,
				shuffle: false,
				song_list: _List_Nil,
				source_list: _List_Nil,
				tvshow_list: _List_Nil,
				url: url,
				volumeSlider: $carwow$elm_slider$SingleSlider$init(
					{max: 100, min: 0, onChange: $author$project$Shared$VolumeSliderChange, step: 1, value: 50}),
				windowHeight: flags.innerHeight,
				windowWidth: flags.innerWidth
			},
			$author$project$Shared$sendActions(
				_List_fromArray(
					['{"jsonrpc": "2.0", "method": "AudioLibrary.GetSongs", "params": { "properties": [ "artist", "duration", "album", "track", "genre", "albumid" ] }, "id": "libSongs"}', '{"jsonrpc": "2.0", "method": "AudioLibrary.GetAlbums", "params": { "properties": ["playcount", "artist", "genre", "rating", "thumbnail", "year", "mood", "style", "dateadded"] }, "id": "libAlbums"}', '{"jsonrpc": "2.0", "method": "AudioLibrary.GetArtists", "params": { "properties": [ "thumbnail", "fanart", "born", "formed", "died", "disbanded", "yearsactive", "mood", "style", "genre" ] }, "id": 1}', '{"jsonrpc": "2.0", "method": "VideoLibrary.GetMusicVideos", "params": { "properties": [ "title", "thumbnail", "artist", "album", "genre", "lastplayed", "year", "runtime", "fanart", "file", "streamdetails" ] }, "id": "libMusicVideos"}', '{"jsonrpc": "2.0", "method": "VideoLibrary.GetMovies", "params": { "properties" : ["art", "rating", "thumbnail", "playcount", "file"] }, "id": "libMovies"}', '{"jsonrpc": "2.0", "method": "VideoLibrary.GetTVShows", "params": { "properties": ["art", "genre", "plot", "title", "originaltitle", "year", "rating", "thumbnail", "playcount", "file", "fanart"] }, "id": "libTvShows"}', '{"jsonrpc": "2.0", "method": "Files.GetSources", "params": { "media": "video" }, "id": 1 }', '{"jsonrpc": "2.0", "method": "Files.GetSources", "params": { "media": "music" }, "id": 1 }', '{"jsonrpc": "2.0", "method": "Player.SetShuffle", "params": { "playerid": 0, "shuffle": false }, "id": 1 }', '{"jsonrpc": "2.0", "method": "Player.SetRepeat", "params": { "playerid": 0, "repeat": "off" }, "id": 1 }'])));
	});
var $author$project$Spa$Generated$Pages$Addons__Model = function (a) {
	return {$: 'Addons__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Addons__Msg = function (a) {
	return {$: 'Addons__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Browser__Model = function (a) {
	return {$: 'Browser__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Browser__Msg = function (a) {
	return {$: 'Browser__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Browser__Source_String__Model = function (a) {
	return {$: 'Browser__Source_String__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Browser__Source_String__Msg = function (a) {
	return {$: 'Browser__Source_String__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Help__Model = function (a) {
	return {$: 'Help__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Help__Msg = function (a) {
	return {$: 'Help__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Lab__Model = function (a) {
	return {$: 'Lab__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Lab__Msg = function (a) {
	return {$: 'Lab__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Movies__Model = function (a) {
	return {$: 'Movies__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Movies__Msg = function (a) {
	return {$: 'Movies__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Movies__Recent__Model = function (a) {
	return {$: 'Movies__Recent__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Movies__Recent__Msg = function (a) {
	return {$: 'Movies__Recent__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Album__Albumid_Int__Model = function (a) {
	return {$: 'Music__Album__Albumid_Int__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Album__Albumid_Int__Msg = function (a) {
	return {$: 'Music__Album__Albumid_Int__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Albums__Model = function (a) {
	return {$: 'Music__Albums__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Albums__Msg = function (a) {
	return {$: 'Music__Albums__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Artist__Artistid_Int__Model = function (a) {
	return {$: 'Music__Artist__Artistid_Int__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Artist__Artistid_Int__Msg = function (a) {
	return {$: 'Music__Artist__Artistid_Int__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Artists__Model = function (a) {
	return {$: 'Music__Artists__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Artists__Msg = function (a) {
	return {$: 'Music__Artists__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Genre__Genre_String__Model = function (a) {
	return {$: 'Music__Genre__Genre_String__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Genre__Genre_String__Msg = function (a) {
	return {$: 'Music__Genre__Genre_String__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Genres__Model = function (a) {
	return {$: 'Music__Genres__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Genres__Msg = function (a) {
	return {$: 'Music__Genres__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Model = function (a) {
	return {$: 'Music__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Msg = function (a) {
	return {$: 'Music__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Top__Top__Model = function (a) {
	return {$: 'Music__Top__Top__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Top__Top__Msg = function (a) {
	return {$: 'Music__Top__Top__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Videos__Model = function (a) {
	return {$: 'Music__Videos__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Music__Videos__Msg = function (a) {
	return {$: 'Music__Videos__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$NotFound__Model = function (a) {
	return {$: 'NotFound__Model', a: a};
};
var $author$project$Spa$Generated$Pages$NotFound__Msg = function (a) {
	return {$: 'NotFound__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Playlists__Model = function (a) {
	return {$: 'Playlists__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Playlists__Msg = function (a) {
	return {$: 'Playlists__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Playlists__Name_String__Model = function (a) {
	return {$: 'Playlists__Name_String__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Playlists__Name_String__Msg = function (a) {
	return {$: 'Playlists__Name_String__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Addons__Model = function (a) {
	return {$: 'Settings__Addons__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Addons__Msg = function (a) {
	return {$: 'Settings__Addons__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Games__Model = function (a) {
	return {$: 'Settings__Kodi__Games__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Games__Msg = function (a) {
	return {$: 'Settings__Kodi__Games__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Interface__Model = function (a) {
	return {$: 'Settings__Kodi__Interface__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Interface__Msg = function (a) {
	return {$: 'Settings__Kodi__Interface__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Media__Model = function (a) {
	return {$: 'Settings__Kodi__Media__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Media__Msg = function (a) {
	return {$: 'Settings__Kodi__Media__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Player__Model = function (a) {
	return {$: 'Settings__Kodi__Player__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Player__Msg = function (a) {
	return {$: 'Settings__Kodi__Player__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Pvr__Model = function (a) {
	return {$: 'Settings__Kodi__Pvr__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Pvr__Msg = function (a) {
	return {$: 'Settings__Kodi__Pvr__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Services__Model = function (a) {
	return {$: 'Settings__Kodi__Services__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__Services__Msg = function (a) {
	return {$: 'Settings__Kodi__Services__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__System__Model = function (a) {
	return {$: 'Settings__Kodi__System__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Kodi__System__Msg = function (a) {
	return {$: 'Settings__Kodi__System__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Nav__Model = function (a) {
	return {$: 'Settings__Nav__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Nav__Msg = function (a) {
	return {$: 'Settings__Nav__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Search__Model = function (a) {
	return {$: 'Settings__Search__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Search__Msg = function (a) {
	return {$: 'Settings__Search__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Web__Model = function (a) {
	return {$: 'Settings__Web__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Settings__Web__Msg = function (a) {
	return {$: 'Settings__Web__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Thumbsup__Model = function (a) {
	return {$: 'Thumbsup__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Thumbsup__Msg = function (a) {
	return {$: 'Thumbsup__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Top__Model = function (a) {
	return {$: 'Top__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Top__Msg = function (a) {
	return {$: 'Top__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Tvshows__Model = function (a) {
	return {$: 'Tvshows__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Tvshows__Msg = function (a) {
	return {$: 'Tvshows__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Tvshows__Recent__Model = function (a) {
	return {$: 'Tvshows__Recent__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Tvshows__Recent__Msg = function (a) {
	return {$: 'Tvshows__Recent__Msg', a: a};
};
var $author$project$Spa$Generated$Pages$Videoplayer__Movieid_Int__Model = function (a) {
	return {$: 'Videoplayer__Movieid_Int__Model', a: a};
};
var $author$project$Spa$Generated$Pages$Videoplayer__Movieid_Int__Msg = function (a) {
	return {$: 'Videoplayer__Movieid_Int__Msg', a: a};
};
var $author$project$Spa$Page$application = function (page) {
	return page;
};
var $author$project$Pages$Addons$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Addons$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Addons$save = F2(
	function (model, shared) {
		return shared;
	});
var $elm$core$Platform$Sub$batch = _Platform_batch;
var $elm$core$Platform$Sub$none = $elm$core$Platform$Sub$batch(_List_Nil);
var $author$project$Pages$Addons$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Addons$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Addons$view = function (model) {
	return {body: _List_Nil, title: 'Addons'};
};
var $author$project$Pages$Addons$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Addons$init, load: $author$project$Pages$Addons$load, save: $author$project$Pages$Addons$save, subscriptions: $author$project$Pages$Addons$subscriptions, update: $author$project$Pages$Addons$update, view: $author$project$Pages$Addons$view});
var $author$project$Pages$Browser$init = F2(
	function (shared, url) {
		return _Utils_Tuple2(
			{route: url.route, source_list: shared.source_list},
			$author$project$Shared$sendActions(
				_List_fromArray(
					['{"jsonrpc": "2.0", "params": {"media": "video"}, "method": "Files.GetSources", "id": 1}', '{"jsonrpc": "2.0", "params": {"media": "music"}, "method": "Files.GetSources", "id": 1}'])));
	});
var $author$project$Pages$Browser$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{source_list: shared.source_list}),
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Browser$save = F2(
	function (model, shared) {
		return _Utils_update(
			shared,
			{album_list: shared.album_list, artist_list: shared.artist_list, connection: shared.connection, controlMenu: shared.controlMenu, currentlyPlaying: shared.currentlyPlaying, flags: shared.flags, genre_list: shared.genre_list, key: shared.key, movie_list: shared.movie_list, players: shared.players, playing: shared.playing, progressSlider: shared.progressSlider, rightSidebarExtended: shared.rightSidebarExtended, searchString: shared.searchString, song_list: shared.song_list, source_list: _List_Nil, tvshow_list: shared.tvshow_list, url: shared.url, volumeSlider: shared.volumeSlider, windowHeight: shared.windowHeight, windowWidth: shared.windowWidth});
	});
var $author$project$Pages$Browser$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Browser$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $elm$url$Url$percentEncode = _Url_percentEncode;
var $mdgriffith$elm_ui$Internal$Model$Colored = F3(
	function (a, b, c) {
		return {$: 'Colored', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Internal$Model$StyleClass = F2(
	function (a, b) {
		return {$: 'StyleClass', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Flag$Flag = function (a) {
	return {$: 'Flag', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$Second = function (a) {
	return {$: 'Second', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$flag = function (i) {
	return (i > 31) ? $mdgriffith$elm_ui$Internal$Flag$Second(1 << (i - 32)) : $mdgriffith$elm_ui$Internal$Flag$Flag(1 << i);
};
var $mdgriffith$elm_ui$Internal$Flag$bgColor = $mdgriffith$elm_ui$Internal$Flag$flag(8);
var $elm$core$Basics$round = _Basics_round;
var $mdgriffith$elm_ui$Internal$Model$floatClass = function (x) {
	return $elm$core$String$fromInt(
		$elm$core$Basics$round(x * 255));
};
var $mdgriffith$elm_ui$Internal$Model$formatColorClass = function (_v0) {
	var red = _v0.a;
	var green = _v0.b;
	var blue = _v0.c;
	var alpha = _v0.d;
	return $mdgriffith$elm_ui$Internal$Model$floatClass(red) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(green) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(blue) + ('-' + $mdgriffith$elm_ui$Internal$Model$floatClass(alpha))))));
};
var $mdgriffith$elm_ui$Element$Background$color = function (clr) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$bgColor,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Colored,
			'bg-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(clr),
			'background-color',
			clr));
};
var $mdgriffith$elm_ui$Internal$Flag$fontColor = $mdgriffith$elm_ui$Internal$Flag$flag(14);
var $mdgriffith$elm_ui$Element$Font$color = function (fontColor) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$fontColor,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Colored,
			'fc-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(fontColor),
			'color',
			fontColor));
};
var $mdgriffith$elm_ui$Internal$Model$Unkeyed = function (a) {
	return {$: 'Unkeyed', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$AsColumn = {$: 'AsColumn'};
var $mdgriffith$elm_ui$Internal$Model$asColumn = $mdgriffith$elm_ui$Internal$Model$AsColumn;
var $mdgriffith$elm_ui$Internal$Style$classes = {above: 'a', active: 'atv', alignBottom: 'ab', alignCenterX: 'cx', alignCenterY: 'cy', alignContainerBottom: 'acb', alignContainerCenterX: 'accx', alignContainerCenterY: 'accy', alignContainerRight: 'acr', alignLeft: 'al', alignRight: 'ar', alignTop: 'at', alignedHorizontally: 'ah', alignedVertically: 'av', any: 's', behind: 'bh', below: 'b', bold: 'w7', borderDashed: 'bd', borderDotted: 'bdt', borderNone: 'bn', borderSolid: 'bs', capturePointerEvents: 'cpe', clip: 'cp', clipX: 'cpx', clipY: 'cpy', column: 'c', container: 'ctr', contentBottom: 'cb', contentCenterX: 'ccx', contentCenterY: 'ccy', contentLeft: 'cl', contentRight: 'cr', contentTop: 'ct', cursorPointer: 'cptr', cursorText: 'ctxt', focus: 'fcs', focusedWithin: 'focus-within', fullSize: 'fs', grid: 'g', hasBehind: 'hbh', heightContent: 'hc', heightExact: 'he', heightFill: 'hf', heightFillPortion: 'hfp', hover: 'hv', imageContainer: 'ic', inFront: 'fr', inputLabel: 'lbl', inputMultiline: 'iml', inputMultilineFiller: 'imlf', inputMultilineParent: 'imlp', inputMultilineWrapper: 'implw', inputText: 'it', italic: 'i', link: 'lnk', nearby: 'nb', noTextSelection: 'notxt', onLeft: 'ol', onRight: 'or', opaque: 'oq', overflowHidden: 'oh', page: 'pg', paragraph: 'p', passPointerEvents: 'ppe', root: 'ui', row: 'r', scrollbars: 'sb', scrollbarsX: 'sbx', scrollbarsY: 'sby', seButton: 'sbt', single: 'e', sizeByCapital: 'cap', spaceEvenly: 'sev', strike: 'sk', text: 't', textCenter: 'tc', textExtraBold: 'w8', textExtraLight: 'w2', textHeavy: 'w9', textJustify: 'tj', textJustifyAll: 'tja', textLeft: 'tl', textLight: 'w3', textMedium: 'w5', textNormalWeight: 'w4', textRight: 'tr', textSemiBold: 'w6', textThin: 'w1', textUnitalicized: 'tun', transition: 'ts', transparent: 'clr', underline: 'u', widthContent: 'wc', widthExact: 'we', widthFill: 'wf', widthFillPortion: 'wfp', wrapped: 'wrp'};
var $mdgriffith$elm_ui$Internal$Model$Generic = {$: 'Generic'};
var $mdgriffith$elm_ui$Internal$Model$div = $mdgriffith$elm_ui$Internal$Model$Generic;
var $mdgriffith$elm_ui$Internal$Model$NoNearbyChildren = {$: 'NoNearbyChildren'};
var $mdgriffith$elm_ui$Internal$Model$columnClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.column);
var $mdgriffith$elm_ui$Internal$Model$gridClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.grid);
var $mdgriffith$elm_ui$Internal$Model$pageClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.page);
var $mdgriffith$elm_ui$Internal$Model$paragraphClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.paragraph);
var $mdgriffith$elm_ui$Internal$Model$rowClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.row);
var $mdgriffith$elm_ui$Internal$Model$singleClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.single);
var $mdgriffith$elm_ui$Internal$Model$contextClasses = function (context) {
	switch (context.$) {
		case 'AsRow':
			return $mdgriffith$elm_ui$Internal$Model$rowClass;
		case 'AsColumn':
			return $mdgriffith$elm_ui$Internal$Model$columnClass;
		case 'AsEl':
			return $mdgriffith$elm_ui$Internal$Model$singleClass;
		case 'AsGrid':
			return $mdgriffith$elm_ui$Internal$Model$gridClass;
		case 'AsParagraph':
			return $mdgriffith$elm_ui$Internal$Model$paragraphClass;
		default:
			return $mdgriffith$elm_ui$Internal$Model$pageClass;
	}
};
var $mdgriffith$elm_ui$Internal$Model$Keyed = function (a) {
	return {$: 'Keyed', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$NoStyleSheet = {$: 'NoStyleSheet'};
var $mdgriffith$elm_ui$Internal$Model$Styled = function (a) {
	return {$: 'Styled', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$Unstyled = function (a) {
	return {$: 'Unstyled', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$addChildren = F2(
	function (existing, nearbyChildren) {
		switch (nearbyChildren.$) {
			case 'NoNearbyChildren':
				return existing;
			case 'ChildrenBehind':
				var behind = nearbyChildren.a;
				return _Utils_ap(behind, existing);
			case 'ChildrenInFront':
				var inFront = nearbyChildren.a;
				return _Utils_ap(existing, inFront);
			default:
				var behind = nearbyChildren.a;
				var inFront = nearbyChildren.b;
				return _Utils_ap(
					behind,
					_Utils_ap(existing, inFront));
		}
	});
var $mdgriffith$elm_ui$Internal$Model$addKeyedChildren = F3(
	function (key, existing, nearbyChildren) {
		switch (nearbyChildren.$) {
			case 'NoNearbyChildren':
				return existing;
			case 'ChildrenBehind':
				var behind = nearbyChildren.a;
				return _Utils_ap(
					A2(
						$elm$core$List$map,
						function (x) {
							return _Utils_Tuple2(key, x);
						},
						behind),
					existing);
			case 'ChildrenInFront':
				var inFront = nearbyChildren.a;
				return _Utils_ap(
					existing,
					A2(
						$elm$core$List$map,
						function (x) {
							return _Utils_Tuple2(key, x);
						},
						inFront));
			default:
				var behind = nearbyChildren.a;
				var inFront = nearbyChildren.b;
				return _Utils_ap(
					A2(
						$elm$core$List$map,
						function (x) {
							return _Utils_Tuple2(key, x);
						},
						behind),
					_Utils_ap(
						existing,
						A2(
							$elm$core$List$map,
							function (x) {
								return _Utils_Tuple2(key, x);
							},
							inFront)));
		}
	});
var $mdgriffith$elm_ui$Internal$Model$AsEl = {$: 'AsEl'};
var $mdgriffith$elm_ui$Internal$Model$asEl = $mdgriffith$elm_ui$Internal$Model$AsEl;
var $mdgriffith$elm_ui$Internal$Model$AsParagraph = {$: 'AsParagraph'};
var $mdgriffith$elm_ui$Internal$Model$asParagraph = $mdgriffith$elm_ui$Internal$Model$AsParagraph;
var $mdgriffith$elm_ui$Internal$Flag$alignBottom = $mdgriffith$elm_ui$Internal$Flag$flag(41);
var $mdgriffith$elm_ui$Internal$Flag$alignRight = $mdgriffith$elm_ui$Internal$Flag$flag(40);
var $mdgriffith$elm_ui$Internal$Flag$centerX = $mdgriffith$elm_ui$Internal$Flag$flag(42);
var $mdgriffith$elm_ui$Internal$Flag$centerY = $mdgriffith$elm_ui$Internal$Flag$flag(43);
var $elm$core$Set$Set_elm_builtin = function (a) {
	return {$: 'Set_elm_builtin', a: a};
};
var $elm$core$Set$empty = $elm$core$Set$Set_elm_builtin($elm$core$Dict$empty);
var $mdgriffith$elm_ui$Internal$Model$lengthClassName = function (x) {
	switch (x.$) {
		case 'Px':
			var px = x.a;
			return $elm$core$String$fromInt(px) + 'px';
		case 'Content':
			return 'auto';
		case 'Fill':
			var i = x.a;
			return $elm$core$String$fromInt(i) + 'fr';
		case 'Min':
			var min = x.a;
			var len = x.b;
			return 'min' + ($elm$core$String$fromInt(min) + $mdgriffith$elm_ui$Internal$Model$lengthClassName(len));
		default:
			var max = x.a;
			var len = x.b;
			return 'max' + ($elm$core$String$fromInt(max) + $mdgriffith$elm_ui$Internal$Model$lengthClassName(len));
	}
};
var $mdgriffith$elm_ui$Internal$Model$transformClass = function (transform) {
	switch (transform.$) {
		case 'Untransformed':
			return $elm$core$Maybe$Nothing;
		case 'Moved':
			var _v1 = transform.a;
			var x = _v1.a;
			var y = _v1.b;
			var z = _v1.c;
			return $elm$core$Maybe$Just(
				'mv-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(x) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(y) + ('-' + $mdgriffith$elm_ui$Internal$Model$floatClass(z))))));
		default:
			var _v2 = transform.a;
			var tx = _v2.a;
			var ty = _v2.b;
			var tz = _v2.c;
			var _v3 = transform.b;
			var sx = _v3.a;
			var sy = _v3.b;
			var sz = _v3.c;
			var _v4 = transform.c;
			var ox = _v4.a;
			var oy = _v4.b;
			var oz = _v4.c;
			var angle = transform.d;
			return $elm$core$Maybe$Just(
				'tfrm-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(tx) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(ty) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(tz) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(sx) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(sy) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(sz) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(ox) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(oy) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(oz) + ('-' + $mdgriffith$elm_ui$Internal$Model$floatClass(angle))))))))))))))))))));
	}
};
var $mdgriffith$elm_ui$Internal$Model$getStyleName = function (style) {
	switch (style.$) {
		case 'Shadows':
			var name = style.a;
			return name;
		case 'Transparency':
			var name = style.a;
			var o = style.b;
			return name;
		case 'Style':
			var _class = style.a;
			return _class;
		case 'FontFamily':
			var name = style.a;
			return name;
		case 'FontSize':
			var i = style.a;
			return 'font-size-' + $elm$core$String$fromInt(i);
		case 'Single':
			var _class = style.a;
			return _class;
		case 'Colored':
			var _class = style.a;
			return _class;
		case 'SpacingStyle':
			var cls = style.a;
			var x = style.b;
			var y = style.c;
			return cls;
		case 'PaddingStyle':
			var cls = style.a;
			var top = style.b;
			var right = style.c;
			var bottom = style.d;
			var left = style.e;
			return cls;
		case 'BorderWidth':
			var cls = style.a;
			var top = style.b;
			var right = style.c;
			var bottom = style.d;
			var left = style.e;
			return cls;
		case 'GridTemplateStyle':
			var template = style.a;
			return 'grid-rows-' + (A2(
				$elm$core$String$join,
				'-',
				A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$lengthClassName, template.rows)) + ('-cols-' + (A2(
				$elm$core$String$join,
				'-',
				A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$lengthClassName, template.columns)) + ('-space-x-' + ($mdgriffith$elm_ui$Internal$Model$lengthClassName(template.spacing.a) + ('-space-y-' + $mdgriffith$elm_ui$Internal$Model$lengthClassName(template.spacing.b)))))));
		case 'GridPosition':
			var pos = style.a;
			return 'gp grid-pos-' + ($elm$core$String$fromInt(pos.row) + ('-' + ($elm$core$String$fromInt(pos.col) + ('-' + ($elm$core$String$fromInt(pos.width) + ('-' + $elm$core$String$fromInt(pos.height)))))));
		case 'PseudoSelector':
			var selector = style.a;
			var subStyle = style.b;
			var name = function () {
				switch (selector.$) {
					case 'Focus':
						return 'fs';
					case 'Hover':
						return 'hv';
					default:
						return 'act';
				}
			}();
			return A2(
				$elm$core$String$join,
				' ',
				A2(
					$elm$core$List$map,
					function (sty) {
						var _v1 = $mdgriffith$elm_ui$Internal$Model$getStyleName(sty);
						if (_v1 === '') {
							return '';
						} else {
							var styleName = _v1;
							return styleName + ('-' + name);
						}
					},
					subStyle));
		default:
			var x = style.a;
			return A2(
				$elm$core$Maybe$withDefault,
				'',
				$mdgriffith$elm_ui$Internal$Model$transformClass(x));
	}
};
var $elm$core$Set$insert = F2(
	function (key, _v0) {
		var dict = _v0.a;
		return $elm$core$Set$Set_elm_builtin(
			A3($elm$core$Dict$insert, key, _Utils_Tuple0, dict));
	});
var $elm$core$Dict$member = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$get, key, dict);
		if (_v0.$ === 'Just') {
			return true;
		} else {
			return false;
		}
	});
var $elm$core$Set$member = F2(
	function (key, _v0) {
		var dict = _v0.a;
		return A2($elm$core$Dict$member, key, dict);
	});
var $mdgriffith$elm_ui$Internal$Model$reduceStyles = F2(
	function (style, nevermind) {
		var cache = nevermind.a;
		var existing = nevermind.b;
		var styleName = $mdgriffith$elm_ui$Internal$Model$getStyleName(style);
		return A2($elm$core$Set$member, styleName, cache) ? nevermind : _Utils_Tuple2(
			A2($elm$core$Set$insert, styleName, cache),
			A2($elm$core$List$cons, style, existing));
	});
var $mdgriffith$elm_ui$Internal$Model$Property = F2(
	function (a, b) {
		return {$: 'Property', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$Style = F2(
	function (a, b) {
		return {$: 'Style', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$dot = function (c) {
	return '.' + c;
};
var $mdgriffith$elm_ui$Internal$Model$formatColor = function (_v0) {
	var red = _v0.a;
	var green = _v0.b;
	var blue = _v0.c;
	var alpha = _v0.d;
	return 'rgba(' + ($elm$core$String$fromInt(
		$elm$core$Basics$round(red * 255)) + ((',' + $elm$core$String$fromInt(
		$elm$core$Basics$round(green * 255))) + ((',' + $elm$core$String$fromInt(
		$elm$core$Basics$round(blue * 255))) + (',' + ($elm$core$String$fromFloat(alpha) + ')')))));
};
var $mdgriffith$elm_ui$Internal$Model$formatBoxShadow = function (shadow) {
	return A2(
		$elm$core$String$join,
		' ',
		A2(
			$elm$core$List$filterMap,
			$elm$core$Basics$identity,
			_List_fromArray(
				[
					shadow.inset ? $elm$core$Maybe$Just('inset') : $elm$core$Maybe$Nothing,
					$elm$core$Maybe$Just(
					$elm$core$String$fromFloat(shadow.offset.a) + 'px'),
					$elm$core$Maybe$Just(
					$elm$core$String$fromFloat(shadow.offset.b) + 'px'),
					$elm$core$Maybe$Just(
					$elm$core$String$fromFloat(shadow.blur) + 'px'),
					$elm$core$Maybe$Just(
					$elm$core$String$fromFloat(shadow.size) + 'px'),
					$elm$core$Maybe$Just(
					$mdgriffith$elm_ui$Internal$Model$formatColor(shadow.color))
				])));
};
var $elm$core$Maybe$map = F2(
	function (f, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return $elm$core$Maybe$Just(
				f(value));
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $elm$core$Tuple$mapFirst = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			func(x),
			y);
	});
var $elm$core$Tuple$mapSecond = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			x,
			func(y));
	});
var $mdgriffith$elm_ui$Internal$Model$renderFocusStyle = function (focus) {
	return _List_fromArray(
		[
			A2(
			$mdgriffith$elm_ui$Internal$Model$Style,
			$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.focusedWithin) + ':focus-within',
			A2(
				$elm$core$List$filterMap,
				$elm$core$Basics$identity,
				_List_fromArray(
					[
						A2(
						$elm$core$Maybe$map,
						function (color) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'border-color',
								$mdgriffith$elm_ui$Internal$Model$formatColor(color));
						},
						focus.borderColor),
						A2(
						$elm$core$Maybe$map,
						function (color) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'background-color',
								$mdgriffith$elm_ui$Internal$Model$formatColor(color));
						},
						focus.backgroundColor),
						A2(
						$elm$core$Maybe$map,
						function (shadow) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'box-shadow',
								$mdgriffith$elm_ui$Internal$Model$formatBoxShadow(
									{
										blur: shadow.blur,
										color: shadow.color,
										inset: false,
										offset: A2(
											$elm$core$Tuple$mapSecond,
											$elm$core$Basics$toFloat,
											A2($elm$core$Tuple$mapFirst, $elm$core$Basics$toFloat, shadow.offset)),
										size: shadow.size
									}));
						},
						focus.shadow),
						$elm$core$Maybe$Just(
						A2($mdgriffith$elm_ui$Internal$Model$Property, 'outline', 'none'))
					]))),
			A2(
			$mdgriffith$elm_ui$Internal$Model$Style,
			($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ':focus .focusable, ') + (($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + '.focusable:focus, ') + ('.ui-slide-bar:focus + ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ' .focusable-thumb'))),
			A2(
				$elm$core$List$filterMap,
				$elm$core$Basics$identity,
				_List_fromArray(
					[
						A2(
						$elm$core$Maybe$map,
						function (color) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'border-color',
								$mdgriffith$elm_ui$Internal$Model$formatColor(color));
						},
						focus.borderColor),
						A2(
						$elm$core$Maybe$map,
						function (color) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'background-color',
								$mdgriffith$elm_ui$Internal$Model$formatColor(color));
						},
						focus.backgroundColor),
						A2(
						$elm$core$Maybe$map,
						function (shadow) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'box-shadow',
								$mdgriffith$elm_ui$Internal$Model$formatBoxShadow(
									{
										blur: shadow.blur,
										color: shadow.color,
										inset: false,
										offset: A2(
											$elm$core$Tuple$mapSecond,
											$elm$core$Basics$toFloat,
											A2($elm$core$Tuple$mapFirst, $elm$core$Basics$toFloat, shadow.offset)),
										size: shadow.size
									}));
						},
						focus.shadow),
						$elm$core$Maybe$Just(
						A2($mdgriffith$elm_ui$Internal$Model$Property, 'outline', 'none'))
					])))
		]);
};
var $elm$virtual_dom$VirtualDom$property = F2(
	function (key, value) {
		return A2(
			_VirtualDom_property,
			_VirtualDom_noInnerHtmlOrFormAction(key),
			_VirtualDom_noJavaScriptOrHtmlUri(value));
	});
var $mdgriffith$elm_ui$Internal$Style$AllChildren = F2(
	function (a, b) {
		return {$: 'AllChildren', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Batch = function (a) {
	return {$: 'Batch', a: a};
};
var $mdgriffith$elm_ui$Internal$Style$Child = F2(
	function (a, b) {
		return {$: 'Child', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Class = F2(
	function (a, b) {
		return {$: 'Class', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Descriptor = F2(
	function (a, b) {
		return {$: 'Descriptor', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Left = {$: 'Left'};
var $mdgriffith$elm_ui$Internal$Style$Prop = F2(
	function (a, b) {
		return {$: 'Prop', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Right = {$: 'Right'};
var $mdgriffith$elm_ui$Internal$Style$Self = function (a) {
	return {$: 'Self', a: a};
};
var $mdgriffith$elm_ui$Internal$Style$Supports = F2(
	function (a, b) {
		return {$: 'Supports', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Content = function (a) {
	return {$: 'Content', a: a};
};
var $mdgriffith$elm_ui$Internal$Style$Bottom = {$: 'Bottom'};
var $mdgriffith$elm_ui$Internal$Style$CenterX = {$: 'CenterX'};
var $mdgriffith$elm_ui$Internal$Style$CenterY = {$: 'CenterY'};
var $mdgriffith$elm_ui$Internal$Style$Top = {$: 'Top'};
var $mdgriffith$elm_ui$Internal$Style$alignments = _List_fromArray(
	[$mdgriffith$elm_ui$Internal$Style$Top, $mdgriffith$elm_ui$Internal$Style$Bottom, $mdgriffith$elm_ui$Internal$Style$Right, $mdgriffith$elm_ui$Internal$Style$Left, $mdgriffith$elm_ui$Internal$Style$CenterX, $mdgriffith$elm_ui$Internal$Style$CenterY]);
var $mdgriffith$elm_ui$Internal$Style$contentName = function (desc) {
	switch (desc.a.$) {
		case 'Top':
			var _v1 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentTop);
		case 'Bottom':
			var _v2 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentBottom);
		case 'Right':
			var _v3 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentRight);
		case 'Left':
			var _v4 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentLeft);
		case 'CenterX':
			var _v5 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentCenterX);
		default:
			var _v6 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY);
	}
};
var $mdgriffith$elm_ui$Internal$Style$selfName = function (desc) {
	switch (desc.a.$) {
		case 'Top':
			var _v1 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignTop);
		case 'Bottom':
			var _v2 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignBottom);
		case 'Right':
			var _v3 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignRight);
		case 'Left':
			var _v4 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignLeft);
		case 'CenterX':
			var _v5 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterX);
		default:
			var _v6 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY);
	}
};
var $mdgriffith$elm_ui$Internal$Style$describeAlignment = function (values) {
	var createDescription = function (alignment) {
		var _v0 = values(alignment);
		var content = _v0.a;
		var indiv = _v0.b;
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$contentName(
					$mdgriffith$elm_ui$Internal$Style$Content(alignment)),
				content),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$selfName(
							$mdgriffith$elm_ui$Internal$Style$Self(alignment)),
						indiv)
					]))
			]);
	};
	return $mdgriffith$elm_ui$Internal$Style$Batch(
		A2($elm$core$List$concatMap, createDescription, $mdgriffith$elm_ui$Internal$Style$alignments));
};
var $mdgriffith$elm_ui$Internal$Style$elDescription = _List_fromArray(
	[
		A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
		A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'column'),
		A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre'),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Descriptor,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.hasBehind),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '0'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.behind),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '-1')
					]))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Descriptor,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.seButton),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.text),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'auto !important')
							]))
					]))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightContent),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', 'auto')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '100000')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFillPortion),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthContent),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
			])),
		$mdgriffith$elm_ui$Internal$Style$describeAlignment(
		function (alignment) {
			switch (alignment.$) {
				case 'Top':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-start')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', '0 !important')
							]));
				case 'Bottom':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-end')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', '0 !important')
							]));
				case 'Right':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-end')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-end')
							]));
				case 'Left':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-start')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
							]));
				case 'CenterX':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'center')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'center')
							]));
				default:
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto')
									]))
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important')
							]));
			}
		})
	]);
var $mdgriffith$elm_ui$Internal$Style$gridAlignments = function (values) {
	var createDescription = function (alignment) {
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$selfName(
							$mdgriffith$elm_ui$Internal$Style$Self(alignment)),
						values(alignment))
					]))
			]);
	};
	return $mdgriffith$elm_ui$Internal$Style$Batch(
		A2($elm$core$List$concatMap, createDescription, $mdgriffith$elm_ui$Internal$Style$alignments));
};
var $mdgriffith$elm_ui$Internal$Style$Above = {$: 'Above'};
var $mdgriffith$elm_ui$Internal$Style$Behind = {$: 'Behind'};
var $mdgriffith$elm_ui$Internal$Style$Below = {$: 'Below'};
var $mdgriffith$elm_ui$Internal$Style$OnLeft = {$: 'OnLeft'};
var $mdgriffith$elm_ui$Internal$Style$OnRight = {$: 'OnRight'};
var $mdgriffith$elm_ui$Internal$Style$Within = {$: 'Within'};
var $mdgriffith$elm_ui$Internal$Style$locations = function () {
	var loc = $mdgriffith$elm_ui$Internal$Style$Above;
	var _v0 = function () {
		switch (loc.$) {
			case 'Above':
				return _Utils_Tuple0;
			case 'Below':
				return _Utils_Tuple0;
			case 'OnRight':
				return _Utils_Tuple0;
			case 'OnLeft':
				return _Utils_Tuple0;
			case 'Within':
				return _Utils_Tuple0;
			default:
				return _Utils_Tuple0;
		}
	}();
	return _List_fromArray(
		[$mdgriffith$elm_ui$Internal$Style$Above, $mdgriffith$elm_ui$Internal$Style$Below, $mdgriffith$elm_ui$Internal$Style$OnRight, $mdgriffith$elm_ui$Internal$Style$OnLeft, $mdgriffith$elm_ui$Internal$Style$Within, $mdgriffith$elm_ui$Internal$Style$Behind]);
}();
var $mdgriffith$elm_ui$Internal$Style$baseSheet = _List_fromArray(
	[
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		'html,body',
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'padding', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		_Utils_ap(
			$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
			_Utils_ap(
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.imageContainer))),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'block'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'img',
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'max-height', '100%'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'object-fit', 'cover')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'img',
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'max-width', '100%'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'object-fit', 'cover')
							]))
					]))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ':focus',
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'outline', 'none')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.root),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', 'auto'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'min-height', '100%'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '0'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				_Utils_ap(
					$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
					$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill)),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inFront),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.nearby),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'fixed'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20')
							]))
					]))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.nearby),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'relative'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border', 'none'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'row'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
				$mdgriffith$elm_ui$Internal$Style$elDescription),
				$mdgriffith$elm_ui$Internal$Style$Batch(
				function (fn) {
					return A2($elm$core$List$map, fn, $mdgriffith$elm_ui$Internal$Style$locations);
				}(
					function (loc) {
						switch (loc.$) {
							case 'Above':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.above),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'bottom', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', 'auto')
												])),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
												])),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
							case 'Below':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.below),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'bottom', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												])),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', 'auto')
												]))
										]));
							case 'OnRight':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.onRight),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
							case 'OnLeft':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.onLeft),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'right', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
							case 'Within':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inFront),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
							default:
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.behind),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
						}
					}))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'relative'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border', 'none'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'row'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'resize', 'none'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-feature-settings', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'box-sizing', 'border-box'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'padding', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-width', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-style', 'solid'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-size', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'color', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-family', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'line-height', '1'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration', 'none'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-style', 'inherit'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.wrapped),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-wrap', 'wrap')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.noTextSelection),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, '-moz-user-select', 'none'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, '-webkit-user-select', 'none'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, '-ms-user-select', 'none'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'user-select', 'none')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.cursorPointer),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'cursor', 'pointer')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.cursorText),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'cursor', 'text')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.passPointerEvents),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none !important')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.capturePointerEvents),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto !important')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.transparent),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.opaque),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.hover, $mdgriffith$elm_ui$Internal$Style$classes.transparent)) + ':hover',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.hover, $mdgriffith$elm_ui$Internal$Style$classes.opaque)) + ':hover',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.focus, $mdgriffith$elm_ui$Internal$Style$classes.transparent)) + ':focus',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.focus, $mdgriffith$elm_ui$Internal$Style$classes.opaque)) + ':focus',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.active, $mdgriffith$elm_ui$Internal$Style$classes.transparent)) + ':active',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.active, $mdgriffith$elm_ui$Internal$Style$classes.opaque)) + ':active',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.transition),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Prop,
						'transition',
						A2(
							$elm$core$String$join,
							', ',
							A2(
								$elm$core$List$map,
								function (x) {
									return x + ' 160ms';
								},
								_List_fromArray(
									['transform', 'opacity', 'filter', 'background-color', 'color', 'font-size']))))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.scrollbars),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow', 'auto'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.scrollbarsX),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-x', 'auto'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '1')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.scrollbarsY),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-y', 'auto'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.column),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '1')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '1')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.clip),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow', 'hidden')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.clipX),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-x', 'hidden')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.clipY),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-y', 'hidden')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthContent),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', 'auto')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.borderNone),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-width', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.borderDashed),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-style', 'dashed')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.borderDotted),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-style', 'dotted')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.borderSolid),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-style', 'solid')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.text),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline-block')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputText),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'line-height', '1.05'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'background', 'transparent'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'inherit')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
				$mdgriffith$elm_ui$Internal$Style$elDescription),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'row'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', '0%'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthExact),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.link),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'stretch !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFillPortion),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'stretch !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '100000')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.container),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'stretch')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'u:first-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerRight,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:first-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterX),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-left', 'auto !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:last-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterX),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-right', 'auto !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:only-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:last-of-type.' + ($mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX + ' ~ u'),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'u:first-of-type.' + ($mdgriffith$elm_ui$Internal$Style$classes.alignContainerRight + (' ~ s.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX)),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						$mdgriffith$elm_ui$Internal$Style$describeAlignment(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-start')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
											]));
								case 'Bottom':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-end')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-end')
											]));
								case 'Right':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-end')
											]),
										_List_Nil);
								case 'Left':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-start')
											]),
										_List_Nil);
								case 'CenterX':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'center')
											]),
										_List_Nil);
								default:
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'center')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'center')
											]));
							}
						}),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.spaceEvenly),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'space-between')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'baseline')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.column),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'column'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', '0px'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'min-height', 'min-content'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightExact),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '100000')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFillPortion),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthContent),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'u:first-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerBottom,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:first-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', '0 !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:last-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', '0 !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:only-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:last-of-type.' + ($mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY + ' ~ u'),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'u:first-of-type.' + ($mdgriffith$elm_ui$Internal$Style$classes.alignContainerBottom + (' ~ s.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY)),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						$mdgriffith$elm_ui$Internal$Style$describeAlignment(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-start')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto')
											]));
								case 'Bottom':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-end')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto')
											]));
								case 'Right':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-end')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-end')
											]));
								case 'Left':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-start')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
											]));
								case 'CenterX':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'center')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'center')
											]));
								default:
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'center')
											]),
										_List_Nil);
							}
						}),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.container),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'stretch !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.spaceEvenly),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'space-between')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.grid),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', '-ms-grid'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'.gp',
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Supports,
						_Utils_Tuple2('display', 'grid'),
						_List_fromArray(
							[
								_Utils_Tuple2('display', 'grid')
							])),
						$mdgriffith$elm_ui$Internal$Style$gridAlignments(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-start')
										]);
								case 'Bottom':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-end')
										]);
								case 'Right':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-end')
										]);
								case 'Left':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-start')
										]);
								case 'CenterX':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'center')
										]);
								default:
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'center')
										]);
							}
						})
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.page),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'block'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any + ':first-child'),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot(
							$mdgriffith$elm_ui$Internal$Style$classes.any + ($mdgriffith$elm_ui$Internal$Style$selfName(
								$mdgriffith$elm_ui$Internal$Style$Self($mdgriffith$elm_ui$Internal$Style$Left)) + (':first-child + .' + $mdgriffith$elm_ui$Internal$Style$classes.any))),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot(
							$mdgriffith$elm_ui$Internal$Style$classes.any + ($mdgriffith$elm_ui$Internal$Style$selfName(
								$mdgriffith$elm_ui$Internal$Style$Self($mdgriffith$elm_ui$Internal$Style$Right)) + (':first-child + .' + $mdgriffith$elm_ui$Internal$Style$classes.any))),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important')
							])),
						$mdgriffith$elm_ui$Internal$Style$describeAlignment(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								case 'Bottom':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								case 'Right':
									return _Utils_Tuple2(
										_List_Nil,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'float', 'right'),
												A2(
												$mdgriffith$elm_ui$Internal$Style$Descriptor,
												'::after',
												_List_fromArray(
													[
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'content', '\"\"'),
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'table'),
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'clear', 'both')
													]))
											]));
								case 'Left':
									return _Utils_Tuple2(
										_List_Nil,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'float', 'left'),
												A2(
												$mdgriffith$elm_ui$Internal$Style$Descriptor,
												'::after',
												_List_fromArray(
													[
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'content', '\"\"'),
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'table'),
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'clear', 'both')
													]))
											]));
								case 'CenterX':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								default:
									return _Utils_Tuple2(_List_Nil, _List_Nil);
							}
						})
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputMultiline),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre-wrap !important'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'background-color', 'transparent')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineWrapper),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineParent),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre-wrap !important'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'cursor', 'text'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineFiller),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre-wrap !important'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'color', 'transparent')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.paragraph),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'block'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'normal'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-wrap', 'break-word'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.hasBehind),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '0'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.behind),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '-1')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$AllChildren,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.text),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'normal')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$AllChildren,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.paragraph),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								'::after',
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'content', 'none')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								'::before',
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'content', 'none')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$AllChildren,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'normal'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthExact),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline-block')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inFront),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.behind),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.above),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.below),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.onRight),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.onLeft),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.text),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'normal')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.column),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline-flex')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.grid),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline-grid')
							])),
						$mdgriffith$elm_ui$Internal$Style$describeAlignment(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								case 'Bottom':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								case 'Right':
									return _Utils_Tuple2(
										_List_Nil,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'float', 'right')
											]));
								case 'Left':
									return _Utils_Tuple2(
										_List_Nil,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'float', 'left')
											]));
								case 'CenterX':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								default:
									return _Utils_Tuple2(_List_Nil, _List_Nil);
							}
						})
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				'.hidden',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'none')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textThin),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '100')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textExtraLight),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '200')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textLight),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '300')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textNormalWeight),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '400')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textMedium),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '500')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textSemiBold),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '600')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.bold),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '700')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textExtraBold),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '800')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textHeavy),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '900')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.italic),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-style', 'italic')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.strike),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration', 'line-through')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.underline),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration', 'underline'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration-skip-ink', 'auto'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration-skip', 'ink')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				_Utils_ap(
					$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.underline),
					$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.strike)),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration', 'line-through underline'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration-skip-ink', 'auto'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration-skip', 'ink')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textUnitalicized),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-style', 'normal')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textJustify),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'justify')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textJustifyAll),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'justify-all')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textCenter),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'center')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textRight),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'right')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textLeft),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'left')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				'.modal',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'fixed'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none')
					]))
			]))
	]);
var $mdgriffith$elm_ui$Internal$Style$fontVariant = function (_var) {
	return _List_fromArray(
		[
			A2(
			$mdgriffith$elm_ui$Internal$Style$Class,
			'.v-' + _var,
			_List_fromArray(
				[
					A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-feature-settings', '\"' + (_var + '\"'))
				])),
			A2(
			$mdgriffith$elm_ui$Internal$Style$Class,
			'.v-' + (_var + '-off'),
			_List_fromArray(
				[
					A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-feature-settings', '\"' + (_var + '\" 0'))
				]))
		]);
};
var $mdgriffith$elm_ui$Internal$Style$commonValues = $elm$core$List$concat(
	_List_fromArray(
		[
			A2(
			$elm$core$List$map,
			function (x) {
				return A2(
					$mdgriffith$elm_ui$Internal$Style$Class,
					'.border-' + $elm$core$String$fromInt(x),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Style$Prop,
							'border-width',
							$elm$core$String$fromInt(x) + 'px')
						]));
			},
			A2($elm$core$List$range, 0, 6)),
			A2(
			$elm$core$List$map,
			function (i) {
				return A2(
					$mdgriffith$elm_ui$Internal$Style$Class,
					'.font-size-' + $elm$core$String$fromInt(i),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Style$Prop,
							'font-size',
							$elm$core$String$fromInt(i) + 'px')
						]));
			},
			A2($elm$core$List$range, 8, 32)),
			A2(
			$elm$core$List$map,
			function (i) {
				return A2(
					$mdgriffith$elm_ui$Internal$Style$Class,
					'.p-' + $elm$core$String$fromInt(i),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Style$Prop,
							'padding',
							$elm$core$String$fromInt(i) + 'px')
						]));
			},
			A2($elm$core$List$range, 0, 24)),
			_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Internal$Style$Class,
				'.v-smcp',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-variant', 'small-caps')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Class,
				'.v-smcp-off',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-variant', 'normal')
					]))
			]),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('zero'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('onum'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('liga'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('dlig'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('ordn'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('tnum'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('afrc'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('frac')
		]));
var $mdgriffith$elm_ui$Internal$Style$explainer = '\n.explain {\n    border: 6px solid rgb(174, 121, 15) !important;\n}\n.explain > .' + ($mdgriffith$elm_ui$Internal$Style$classes.any + (' {\n    border: 4px dashed rgb(0, 151, 167) !important;\n}\n\n.ctr {\n    border: none !important;\n}\n.explain > .ctr > .' + ($mdgriffith$elm_ui$Internal$Style$classes.any + ' {\n    border: 4px dashed rgb(0, 151, 167) !important;\n}\n\n')));
var $mdgriffith$elm_ui$Internal$Style$inputTextReset = '\ninput[type="search"],\ninput[type="search"]::-webkit-search-decoration,\ninput[type="search"]::-webkit-search-cancel-button,\ninput[type="search"]::-webkit-search-results-button,\ninput[type="search"]::-webkit-search-results-decoration {\n  -webkit-appearance:none;\n}\n';
var $mdgriffith$elm_ui$Internal$Style$sliderReset = '\ninput[type=range] {\n  -webkit-appearance: none; \n  background: transparent;\n  position:absolute;\n  left:0;\n  top:0;\n  z-index:10;\n  width: 100%;\n  outline: dashed 1px;\n  height: 100%;\n  opacity: 0;\n}\n';
var $mdgriffith$elm_ui$Internal$Style$thumbReset = '\ninput[type=range]::-webkit-slider-thumb {\n    -webkit-appearance: none;\n    opacity: 0.5;\n    width: 80px;\n    height: 80px;\n    background-color: black;\n    border:none;\n    border-radius: 5px;\n}\ninput[type=range]::-moz-range-thumb {\n    opacity: 0.5;\n    width: 80px;\n    height: 80px;\n    background-color: black;\n    border:none;\n    border-radius: 5px;\n}\ninput[type=range]::-ms-thumb {\n    opacity: 0.5;\n    width: 80px;\n    height: 80px;\n    background-color: black;\n    border:none;\n    border-radius: 5px;\n}\ninput[type=range][orient=vertical]{\n    writing-mode: bt-lr; /* IE */\n    -webkit-appearance: slider-vertical;  /* WebKit */\n}\n';
var $mdgriffith$elm_ui$Internal$Style$trackReset = '\ninput[type=range]::-moz-range-track {\n    background: transparent;\n    cursor: pointer;\n}\ninput[type=range]::-ms-track {\n    background: transparent;\n    cursor: pointer;\n}\ninput[type=range]::-webkit-slider-runnable-track {\n    background: transparent;\n    cursor: pointer;\n}\n';
var $mdgriffith$elm_ui$Internal$Style$overrides = '@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row) + (' > ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + (' { flex-basis: auto !important; } ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row) + (' > ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.container) + (' { flex-basis: auto !important; }}' + ($mdgriffith$elm_ui$Internal$Style$inputTextReset + ($mdgriffith$elm_ui$Internal$Style$sliderReset + ($mdgriffith$elm_ui$Internal$Style$trackReset + ($mdgriffith$elm_ui$Internal$Style$thumbReset + $mdgriffith$elm_ui$Internal$Style$explainer)))))))))))))));
var $elm$core$String$concat = function (strings) {
	return A2($elm$core$String$join, '', strings);
};
var $mdgriffith$elm_ui$Internal$Style$Intermediate = function (a) {
	return {$: 'Intermediate', a: a};
};
var $mdgriffith$elm_ui$Internal$Style$emptyIntermediate = F2(
	function (selector, closing) {
		return $mdgriffith$elm_ui$Internal$Style$Intermediate(
			{closing: closing, others: _List_Nil, props: _List_Nil, selector: selector});
	});
var $mdgriffith$elm_ui$Internal$Style$renderRules = F2(
	function (_v0, rulesToRender) {
		var parent = _v0.a;
		var generateIntermediates = F2(
			function (rule, rendered) {
				switch (rule.$) {
					case 'Prop':
						var name = rule.a;
						var val = rule.b;
						return _Utils_update(
							rendered,
							{
								props: A2(
									$elm$core$List$cons,
									_Utils_Tuple2(name, val),
									rendered.props)
							});
					case 'Supports':
						var _v2 = rule.a;
						var prop = _v2.a;
						var value = _v2.b;
						var props = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									$mdgriffith$elm_ui$Internal$Style$Intermediate(
										{closing: '\n}', others: _List_Nil, props: props, selector: '@supports (' + (prop + (':' + (value + (') {' + parent.selector))))}),
									rendered.others)
							});
					case 'Adjacent':
						var selector = rule.a;
						var adjRules = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, parent.selector + (' + ' + selector), ''),
										adjRules),
									rendered.others)
							});
					case 'Child':
						var child = rule.a;
						var childRules = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, parent.selector + (' > ' + child), ''),
										childRules),
									rendered.others)
							});
					case 'AllChildren':
						var child = rule.a;
						var childRules = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, parent.selector + (' ' + child), ''),
										childRules),
									rendered.others)
							});
					case 'Descriptor':
						var descriptor = rule.a;
						var descriptorRules = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2(
											$mdgriffith$elm_ui$Internal$Style$emptyIntermediate,
											_Utils_ap(parent.selector, descriptor),
											''),
										descriptorRules),
									rendered.others)
							});
					default:
						var batched = rule.a;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, parent.selector, ''),
										batched),
									rendered.others)
							});
				}
			});
		return $mdgriffith$elm_ui$Internal$Style$Intermediate(
			A3($elm$core$List$foldr, generateIntermediates, parent, rulesToRender));
	});
var $mdgriffith$elm_ui$Internal$Style$renderCompact = function (styleClasses) {
	var renderValues = function (values) {
		return $elm$core$String$concat(
			A2(
				$elm$core$List$map,
				function (_v3) {
					var x = _v3.a;
					var y = _v3.b;
					return x + (':' + (y + ';'));
				},
				values));
	};
	var renderClass = function (rule) {
		var _v2 = rule.props;
		if (!_v2.b) {
			return '';
		} else {
			return rule.selector + ('{' + (renderValues(rule.props) + (rule.closing + '}')));
		}
	};
	var renderIntermediate = function (_v0) {
		var rule = _v0.a;
		return _Utils_ap(
			renderClass(rule),
			$elm$core$String$concat(
				A2($elm$core$List$map, renderIntermediate, rule.others)));
	};
	return $elm$core$String$concat(
		A2(
			$elm$core$List$map,
			renderIntermediate,
			A3(
				$elm$core$List$foldr,
				F2(
					function (_v1, existing) {
						var name = _v1.a;
						var styleRules = _v1.b;
						return A2(
							$elm$core$List$cons,
							A2(
								$mdgriffith$elm_ui$Internal$Style$renderRules,
								A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, name, ''),
								styleRules),
							existing);
					}),
				_List_Nil,
				styleClasses)));
};
var $mdgriffith$elm_ui$Internal$Style$rules = _Utils_ap(
	$mdgriffith$elm_ui$Internal$Style$overrides,
	$mdgriffith$elm_ui$Internal$Style$renderCompact(
		_Utils_ap($mdgriffith$elm_ui$Internal$Style$baseSheet, $mdgriffith$elm_ui$Internal$Style$commonValues)));
var $mdgriffith$elm_ui$Internal$Model$staticRoot = function (opts) {
	var _v0 = opts.mode;
	switch (_v0.$) {
		case 'Layout':
			return A3(
				$elm$virtual_dom$VirtualDom$node,
				'div',
				_List_Nil,
				_List_fromArray(
					[
						A3(
						$elm$virtual_dom$VirtualDom$node,
						'style',
						_List_Nil,
						_List_fromArray(
							[
								$elm$virtual_dom$VirtualDom$text($mdgriffith$elm_ui$Internal$Style$rules)
							]))
					]));
		case 'NoStaticStyleSheet':
			return $elm$virtual_dom$VirtualDom$text('');
		default:
			return A3(
				$elm$virtual_dom$VirtualDom$node,
				'elm-ui-static-rules',
				_List_fromArray(
					[
						A2(
						$elm$virtual_dom$VirtualDom$property,
						'rules',
						$elm$json$Json$Encode$string($mdgriffith$elm_ui$Internal$Style$rules))
					]),
				_List_Nil);
	}
};
var $elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$fontName = function (font) {
	switch (font.$) {
		case 'Serif':
			return 'serif';
		case 'SansSerif':
			return 'sans-serif';
		case 'Monospace':
			return 'monospace';
		case 'Typeface':
			var name = font.a;
			return '\"' + (name + '\"');
		case 'ImportFont':
			var name = font.a;
			var url = font.b;
			return '\"' + (name + '\"');
		default:
			var name = font.a.name;
			return '\"' + (name + '\"');
	}
};
var $mdgriffith$elm_ui$Internal$Model$isSmallCaps = function (_var) {
	switch (_var.$) {
		case 'VariantActive':
			var name = _var.a;
			return name === 'smcp';
		case 'VariantOff':
			var name = _var.a;
			return false;
		default:
			var name = _var.a;
			var index = _var.b;
			return (name === 'smcp') && (index === 1);
	}
};
var $mdgriffith$elm_ui$Internal$Model$hasSmallCaps = function (typeface) {
	if (typeface.$ === 'FontWith') {
		var font = typeface.a;
		return A2($elm$core$List$any, $mdgriffith$elm_ui$Internal$Model$isSmallCaps, font.variants);
	} else {
		return false;
	}
};
var $elm$core$Basics$min = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) < 0) ? x : y;
	});
var $mdgriffith$elm_ui$Internal$Model$renderProps = F3(
	function (force, _v0, existing) {
		var key = _v0.a;
		var val = _v0.b;
		return force ? (existing + ('\n  ' + (key + (': ' + (val + ' !important;'))))) : (existing + ('\n  ' + (key + (': ' + (val + ';')))));
	});
var $mdgriffith$elm_ui$Internal$Model$renderStyle = F4(
	function (options, maybePseudo, selector, props) {
		if (maybePseudo.$ === 'Nothing') {
			return _List_fromArray(
				[
					selector + ('{' + (A3(
					$elm$core$List$foldl,
					$mdgriffith$elm_ui$Internal$Model$renderProps(false),
					'',
					props) + '\n}'))
				]);
		} else {
			var pseudo = maybePseudo.a;
			switch (pseudo.$) {
				case 'Hover':
					var _v2 = options.hover;
					switch (_v2.$) {
						case 'NoHover':
							return _List_Nil;
						case 'ForceHover':
							return _List_fromArray(
								[
									selector + ('-hv {' + (A3(
									$elm$core$List$foldl,
									$mdgriffith$elm_ui$Internal$Model$renderProps(true),
									'',
									props) + '\n}'))
								]);
						default:
							return _List_fromArray(
								[
									selector + ('-hv:hover {' + (A3(
									$elm$core$List$foldl,
									$mdgriffith$elm_ui$Internal$Model$renderProps(false),
									'',
									props) + '\n}'))
								]);
					}
				case 'Focus':
					var renderedProps = A3(
						$elm$core$List$foldl,
						$mdgriffith$elm_ui$Internal$Model$renderProps(false),
						'',
						props);
					return _List_fromArray(
						[
							selector + ('-fs:focus {' + (renderedProps + '\n}')),
							('.' + ($mdgriffith$elm_ui$Internal$Style$classes.any + (':focus ' + (selector + '-fs  {')))) + (renderedProps + '\n}'),
							(selector + '-fs:focus-within {') + (renderedProps + '\n}'),
							('.ui-slide-bar:focus + ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + (' .focusable-thumb' + (selector + '-fs {')))) + (renderedProps + '\n}')
						]);
				default:
					return _List_fromArray(
						[
							selector + ('-act:active {' + (A3(
							$elm$core$List$foldl,
							$mdgriffith$elm_ui$Internal$Model$renderProps(false),
							'',
							props) + '\n}'))
						]);
			}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$renderVariant = function (_var) {
	switch (_var.$) {
		case 'VariantActive':
			var name = _var.a;
			return '\"' + (name + '\"');
		case 'VariantOff':
			var name = _var.a;
			return '\"' + (name + '\" 0');
		default:
			var name = _var.a;
			var index = _var.b;
			return '\"' + (name + ('\" ' + $elm$core$String$fromInt(index)));
	}
};
var $mdgriffith$elm_ui$Internal$Model$renderVariants = function (typeface) {
	if (typeface.$ === 'FontWith') {
		var font = typeface.a;
		return $elm$core$Maybe$Just(
			A2(
				$elm$core$String$join,
				', ',
				A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$renderVariant, font.variants)));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $mdgriffith$elm_ui$Internal$Model$transformValue = function (transform) {
	switch (transform.$) {
		case 'Untransformed':
			return $elm$core$Maybe$Nothing;
		case 'Moved':
			var _v1 = transform.a;
			var x = _v1.a;
			var y = _v1.b;
			var z = _v1.c;
			return $elm$core$Maybe$Just(
				'translate3d(' + ($elm$core$String$fromFloat(x) + ('px, ' + ($elm$core$String$fromFloat(y) + ('px, ' + ($elm$core$String$fromFloat(z) + 'px)'))))));
		default:
			var _v2 = transform.a;
			var tx = _v2.a;
			var ty = _v2.b;
			var tz = _v2.c;
			var _v3 = transform.b;
			var sx = _v3.a;
			var sy = _v3.b;
			var sz = _v3.c;
			var _v4 = transform.c;
			var ox = _v4.a;
			var oy = _v4.b;
			var oz = _v4.c;
			var angle = transform.d;
			var translate = 'translate3d(' + ($elm$core$String$fromFloat(tx) + ('px, ' + ($elm$core$String$fromFloat(ty) + ('px, ' + ($elm$core$String$fromFloat(tz) + 'px)')))));
			var scale = 'scale3d(' + ($elm$core$String$fromFloat(sx) + (', ' + ($elm$core$String$fromFloat(sy) + (', ' + ($elm$core$String$fromFloat(sz) + ')')))));
			var rotate = 'rotate3d(' + ($elm$core$String$fromFloat(ox) + (', ' + ($elm$core$String$fromFloat(oy) + (', ' + ($elm$core$String$fromFloat(oz) + (', ' + ($elm$core$String$fromFloat(angle) + 'rad)')))))));
			return $elm$core$Maybe$Just(translate + (' ' + (scale + (' ' + rotate))));
	}
};
var $mdgriffith$elm_ui$Internal$Model$renderStyleRule = F3(
	function (options, rule, maybePseudo) {
		switch (rule.$) {
			case 'Style':
				var selector = rule.a;
				var props = rule.b;
				return A4($mdgriffith$elm_ui$Internal$Model$renderStyle, options, maybePseudo, selector, props);
			case 'Shadows':
				var name = rule.a;
				var prop = rule.b;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.' + name,
					_List_fromArray(
						[
							A2($mdgriffith$elm_ui$Internal$Model$Property, 'box-shadow', prop)
						]));
			case 'Transparency':
				var name = rule.a;
				var transparency = rule.b;
				var opacity = A2(
					$elm$core$Basics$max,
					0,
					A2($elm$core$Basics$min, 1, 1 - transparency));
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.' + name,
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							'opacity',
							$elm$core$String$fromFloat(opacity))
						]));
			case 'FontSize':
				var i = rule.a;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.font-size-' + $elm$core$String$fromInt(i),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							'font-size',
							$elm$core$String$fromInt(i) + 'px')
						]));
			case 'FontFamily':
				var name = rule.a;
				var typefaces = rule.b;
				var features = A2(
					$elm$core$String$join,
					', ',
					A2($elm$core$List$filterMap, $mdgriffith$elm_ui$Internal$Model$renderVariants, typefaces));
				var families = _List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Model$Property,
						'font-family',
						A2(
							$elm$core$String$join,
							', ',
							A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$fontName, typefaces))),
						A2($mdgriffith$elm_ui$Internal$Model$Property, 'font-feature-settings', features),
						A2(
						$mdgriffith$elm_ui$Internal$Model$Property,
						'font-variant',
						A2($elm$core$List$any, $mdgriffith$elm_ui$Internal$Model$hasSmallCaps, typefaces) ? 'small-caps' : 'normal')
					]);
				return A4($mdgriffith$elm_ui$Internal$Model$renderStyle, options, maybePseudo, '.' + name, families);
			case 'Single':
				var _class = rule.a;
				var prop = rule.b;
				var val = rule.c;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.' + _class,
					_List_fromArray(
						[
							A2($mdgriffith$elm_ui$Internal$Model$Property, prop, val)
						]));
			case 'Colored':
				var _class = rule.a;
				var prop = rule.b;
				var color = rule.c;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.' + _class,
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							prop,
							$mdgriffith$elm_ui$Internal$Model$formatColor(color))
						]));
			case 'SpacingStyle':
				var cls = rule.a;
				var x = rule.b;
				var y = rule.c;
				var yPx = $elm$core$String$fromInt(y) + 'px';
				var xPx = $elm$core$String$fromInt(x) + 'px';
				var single = '.' + $mdgriffith$elm_ui$Internal$Style$classes.single;
				var row = '.' + $mdgriffith$elm_ui$Internal$Style$classes.row;
				var wrappedRow = '.' + ($mdgriffith$elm_ui$Internal$Style$classes.wrapped + row);
				var right = '.' + $mdgriffith$elm_ui$Internal$Style$classes.alignRight;
				var paragraph = '.' + $mdgriffith$elm_ui$Internal$Style$classes.paragraph;
				var page = '.' + $mdgriffith$elm_ui$Internal$Style$classes.page;
				var left = '.' + $mdgriffith$elm_ui$Internal$Style$classes.alignLeft;
				var halfY = $elm$core$String$fromFloat(y / 2) + 'px';
				var halfX = $elm$core$String$fromFloat(x / 2) + 'px';
				var column = '.' + $mdgriffith$elm_ui$Internal$Style$classes.column;
				var _class = '.' + cls;
				var any = '.' + $mdgriffith$elm_ui$Internal$Style$classes.any;
				return $elm$core$List$concat(
					_List_fromArray(
						[
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (row + (' > ' + (any + (' + ' + any)))),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-left', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (wrappedRow + (' > ' + any)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin', halfY + (' ' + halfX))
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (column + (' > ' + (any + (' + ' + any)))),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-top', yPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (page + (' > ' + (any + (' + ' + any)))),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-top', yPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (page + (' > ' + left)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-right', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (page + (' > ' + right)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-left', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_Utils_ap(_class, paragraph),
							_List_fromArray(
								[
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'line-height',
									'calc(1em + ' + ($elm$core$String$fromInt(y) + 'px)'))
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							'textarea' + (any + _class),
							_List_fromArray(
								[
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'line-height',
									'calc(1em + ' + ($elm$core$String$fromInt(y) + 'px)')),
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'height',
									'calc(100% + ' + ($elm$core$String$fromInt(y) + 'px)'))
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (paragraph + (' > ' + left)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-right', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (paragraph + (' > ' + right)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-left', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (paragraph + '::after'),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'content', '\'\''),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'display', 'block'),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'height', '0'),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'width', '0'),
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'margin-top',
									$elm$core$String$fromInt((-1) * ((y / 2) | 0)) + 'px')
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (paragraph + '::before'),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'content', '\'\''),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'display', 'block'),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'height', '0'),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'width', '0'),
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'margin-bottom',
									$elm$core$String$fromInt((-1) * ((y / 2) | 0)) + 'px')
								]))
						]));
			case 'PaddingStyle':
				var cls = rule.a;
				var top = rule.b;
				var right = rule.c;
				var bottom = rule.d;
				var left = rule.e;
				var _class = '.' + cls;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					_class,
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							'padding',
							$elm$core$String$fromFloat(top) + ('px ' + ($elm$core$String$fromFloat(right) + ('px ' + ($elm$core$String$fromFloat(bottom) + ('px ' + ($elm$core$String$fromFloat(left) + 'px')))))))
						]));
			case 'BorderWidth':
				var cls = rule.a;
				var top = rule.b;
				var right = rule.c;
				var bottom = rule.d;
				var left = rule.e;
				var _class = '.' + cls;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					_class,
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							'border-width',
							$elm$core$String$fromInt(top) + ('px ' + ($elm$core$String$fromInt(right) + ('px ' + ($elm$core$String$fromInt(bottom) + ('px ' + ($elm$core$String$fromInt(left) + 'px')))))))
						]));
			case 'GridTemplateStyle':
				var template = rule.a;
				var toGridLengthHelper = F3(
					function (minimum, maximum, x) {
						toGridLengthHelper:
						while (true) {
							switch (x.$) {
								case 'Px':
									var px = x.a;
									return $elm$core$String$fromInt(px) + 'px';
								case 'Content':
									var _v2 = _Utils_Tuple2(minimum, maximum);
									if (_v2.a.$ === 'Nothing') {
										if (_v2.b.$ === 'Nothing') {
											var _v3 = _v2.a;
											var _v4 = _v2.b;
											return 'max-content';
										} else {
											var _v6 = _v2.a;
											var maxSize = _v2.b.a;
											return 'minmax(max-content, ' + ($elm$core$String$fromInt(maxSize) + 'px)');
										}
									} else {
										if (_v2.b.$ === 'Nothing') {
											var minSize = _v2.a.a;
											var _v5 = _v2.b;
											return 'minmax(' + ($elm$core$String$fromInt(minSize) + ('px, ' + 'max-content)'));
										} else {
											var minSize = _v2.a.a;
											var maxSize = _v2.b.a;
											return 'minmax(' + ($elm$core$String$fromInt(minSize) + ('px, ' + ($elm$core$String$fromInt(maxSize) + 'px)')));
										}
									}
								case 'Fill':
									var i = x.a;
									var _v7 = _Utils_Tuple2(minimum, maximum);
									if (_v7.a.$ === 'Nothing') {
										if (_v7.b.$ === 'Nothing') {
											var _v8 = _v7.a;
											var _v9 = _v7.b;
											return $elm$core$String$fromInt(i) + 'fr';
										} else {
											var _v11 = _v7.a;
											var maxSize = _v7.b.a;
											return 'minmax(max-content, ' + ($elm$core$String$fromInt(maxSize) + 'px)');
										}
									} else {
										if (_v7.b.$ === 'Nothing') {
											var minSize = _v7.a.a;
											var _v10 = _v7.b;
											return 'minmax(' + ($elm$core$String$fromInt(minSize) + ('px, ' + ($elm$core$String$fromInt(i) + ('fr' + 'fr)'))));
										} else {
											var minSize = _v7.a.a;
											var maxSize = _v7.b.a;
											return 'minmax(' + ($elm$core$String$fromInt(minSize) + ('px, ' + ($elm$core$String$fromInt(maxSize) + 'px)')));
										}
									}
								case 'Min':
									var m = x.a;
									var len = x.b;
									var $temp$minimum = $elm$core$Maybe$Just(m),
										$temp$maximum = maximum,
										$temp$x = len;
									minimum = $temp$minimum;
									maximum = $temp$maximum;
									x = $temp$x;
									continue toGridLengthHelper;
								default:
									var m = x.a;
									var len = x.b;
									var $temp$minimum = minimum,
										$temp$maximum = $elm$core$Maybe$Just(m),
										$temp$x = len;
									minimum = $temp$minimum;
									maximum = $temp$maximum;
									x = $temp$x;
									continue toGridLengthHelper;
							}
						}
					});
				var toGridLength = function (x) {
					return A3(toGridLengthHelper, $elm$core$Maybe$Nothing, $elm$core$Maybe$Nothing, x);
				};
				var xSpacing = toGridLength(template.spacing.a);
				var ySpacing = toGridLength(template.spacing.b);
				var rows = function (x) {
					return 'grid-template-rows: ' + (x + ';');
				}(
					A2(
						$elm$core$String$join,
						' ',
						A2($elm$core$List$map, toGridLength, template.rows)));
				var msRows = function (x) {
					return '-ms-grid-rows: ' + (x + ';');
				}(
					A2(
						$elm$core$String$join,
						ySpacing,
						A2($elm$core$List$map, toGridLength, template.columns)));
				var msColumns = function (x) {
					return '-ms-grid-columns: ' + (x + ';');
				}(
					A2(
						$elm$core$String$join,
						ySpacing,
						A2($elm$core$List$map, toGridLength, template.columns)));
				var gapY = 'grid-row-gap:' + (toGridLength(template.spacing.b) + ';');
				var gapX = 'grid-column-gap:' + (toGridLength(template.spacing.a) + ';');
				var columns = function (x) {
					return 'grid-template-columns: ' + (x + ';');
				}(
					A2(
						$elm$core$String$join,
						' ',
						A2($elm$core$List$map, toGridLength, template.columns)));
				var _class = '.grid-rows-' + (A2(
					$elm$core$String$join,
					'-',
					A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$lengthClassName, template.rows)) + ('-cols-' + (A2(
					$elm$core$String$join,
					'-',
					A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$lengthClassName, template.columns)) + ('-space-x-' + ($mdgriffith$elm_ui$Internal$Model$lengthClassName(template.spacing.a) + ('-space-y-' + $mdgriffith$elm_ui$Internal$Model$lengthClassName(template.spacing.b)))))));
				var modernGrid = _class + ('{' + (columns + (rows + (gapX + (gapY + '}')))));
				var supports = '@supports (display:grid) {' + (modernGrid + '}');
				var base = _class + ('{' + (msColumns + (msRows + '}')));
				return _List_fromArray(
					[base, supports]);
			case 'GridPosition':
				var position = rule.a;
				var msPosition = A2(
					$elm$core$String$join,
					' ',
					_List_fromArray(
						[
							'-ms-grid-row: ' + ($elm$core$String$fromInt(position.row) + ';'),
							'-ms-grid-row-span: ' + ($elm$core$String$fromInt(position.height) + ';'),
							'-ms-grid-column: ' + ($elm$core$String$fromInt(position.col) + ';'),
							'-ms-grid-column-span: ' + ($elm$core$String$fromInt(position.width) + ';')
						]));
				var modernPosition = A2(
					$elm$core$String$join,
					' ',
					_List_fromArray(
						[
							'grid-row: ' + ($elm$core$String$fromInt(position.row) + (' / ' + ($elm$core$String$fromInt(position.row + position.height) + ';'))),
							'grid-column: ' + ($elm$core$String$fromInt(position.col) + (' / ' + ($elm$core$String$fromInt(position.col + position.width) + ';')))
						]));
				var _class = '.grid-pos-' + ($elm$core$String$fromInt(position.row) + ('-' + ($elm$core$String$fromInt(position.col) + ('-' + ($elm$core$String$fromInt(position.width) + ('-' + $elm$core$String$fromInt(position.height)))))));
				var modernGrid = _class + ('{' + (modernPosition + '}'));
				var supports = '@supports (display:grid) {' + (modernGrid + '}');
				var base = _class + ('{' + (msPosition + '}'));
				return _List_fromArray(
					[base, supports]);
			case 'PseudoSelector':
				var _class = rule.a;
				var styles = rule.b;
				var renderPseudoRule = function (style) {
					return A3(
						$mdgriffith$elm_ui$Internal$Model$renderStyleRule,
						options,
						style,
						$elm$core$Maybe$Just(_class));
				};
				return A2($elm$core$List$concatMap, renderPseudoRule, styles);
			default:
				var transform = rule.a;
				var val = $mdgriffith$elm_ui$Internal$Model$transformValue(transform);
				var _class = $mdgriffith$elm_ui$Internal$Model$transformClass(transform);
				var _v12 = _Utils_Tuple2(_class, val);
				if ((_v12.a.$ === 'Just') && (_v12.b.$ === 'Just')) {
					var cls = _v12.a.a;
					var v = _v12.b.a;
					return A4(
						$mdgriffith$elm_ui$Internal$Model$renderStyle,
						options,
						maybePseudo,
						'.' + cls,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Model$Property, 'transform', v)
							]));
				} else {
					return _List_Nil;
				}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$encodeStyles = F2(
	function (options, stylesheet) {
		return $elm$json$Json$Encode$object(
			A2(
				$elm$core$List$map,
				function (style) {
					var styled = A3($mdgriffith$elm_ui$Internal$Model$renderStyleRule, options, style, $elm$core$Maybe$Nothing);
					return _Utils_Tuple2(
						$mdgriffith$elm_ui$Internal$Model$getStyleName(style),
						A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, styled));
				},
				stylesheet));
	});
var $mdgriffith$elm_ui$Internal$Model$bracket = F2(
	function (selector, rules) {
		var renderPair = function (_v0) {
			var name = _v0.a;
			var val = _v0.b;
			return name + (': ' + (val + ';'));
		};
		return selector + (' {' + (A2(
			$elm$core$String$join,
			'',
			A2($elm$core$List$map, renderPair, rules)) + '}'));
	});
var $mdgriffith$elm_ui$Internal$Model$fontRule = F3(
	function (name, modifier, _v0) {
		var parentAdj = _v0.a;
		var textAdjustment = _v0.b;
		return _List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Model$bracket, '.' + (name + ('.' + (modifier + (', ' + ('.' + (name + (' .' + modifier))))))), parentAdj),
				A2($mdgriffith$elm_ui$Internal$Model$bracket, '.' + (name + ('.' + (modifier + ('> .' + ($mdgriffith$elm_ui$Internal$Style$classes.text + (', .' + (name + (' .' + (modifier + (' > .' + $mdgriffith$elm_ui$Internal$Style$classes.text)))))))))), textAdjustment)
			]);
	});
var $mdgriffith$elm_ui$Internal$Model$renderFontAdjustmentRule = F3(
	function (fontToAdjust, _v0, otherFontName) {
		var full = _v0.a;
		var capital = _v0.b;
		var name = _Utils_eq(fontToAdjust, otherFontName) ? fontToAdjust : (otherFontName + (' .' + fontToAdjust));
		return A2(
			$elm$core$String$join,
			' ',
			_Utils_ap(
				A3($mdgriffith$elm_ui$Internal$Model$fontRule, name, $mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital, capital),
				A3($mdgriffith$elm_ui$Internal$Model$fontRule, name, $mdgriffith$elm_ui$Internal$Style$classes.fullSize, full)));
	});
var $mdgriffith$elm_ui$Internal$Model$renderNullAdjustmentRule = F2(
	function (fontToAdjust, otherFontName) {
		var name = _Utils_eq(fontToAdjust, otherFontName) ? fontToAdjust : (otherFontName + (' .' + fontToAdjust));
		return A2(
			$elm$core$String$join,
			' ',
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Internal$Model$bracket,
					'.' + (name + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital + (', ' + ('.' + (name + (' .' + $mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital))))))),
					_List_fromArray(
						[
							_Utils_Tuple2('line-height', '1')
						])),
					A2(
					$mdgriffith$elm_ui$Internal$Model$bracket,
					'.' + (name + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital + ('> .' + ($mdgriffith$elm_ui$Internal$Style$classes.text + (', .' + (name + (' .' + ($mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital + (' > .' + $mdgriffith$elm_ui$Internal$Style$classes.text)))))))))),
					_List_fromArray(
						[
							_Utils_Tuple2('vertical-align', '0'),
							_Utils_Tuple2('line-height', '1')
						]))
				]));
	});
var $mdgriffith$elm_ui$Internal$Model$adjust = F3(
	function (size, height, vertical) {
		return {height: height / size, size: size, vertical: vertical};
	});
var $elm$core$List$filter = F2(
	function (isGood, list) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, xs) {
					return isGood(x) ? A2($elm$core$List$cons, x, xs) : xs;
				}),
			_List_Nil,
			list);
	});
var $elm$core$List$maximum = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(
			A3($elm$core$List$foldl, $elm$core$Basics$max, x, xs));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $elm$core$List$minimum = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(
			A3($elm$core$List$foldl, $elm$core$Basics$min, x, xs));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $mdgriffith$elm_ui$Internal$Model$convertAdjustment = function (adjustment) {
	var lines = _List_fromArray(
		[adjustment.capital, adjustment.baseline, adjustment.descender, adjustment.lowercase]);
	var lineHeight = 1.5;
	var normalDescender = (lineHeight - 1) / 2;
	var oldMiddle = lineHeight / 2;
	var descender = A2(
		$elm$core$Maybe$withDefault,
		adjustment.descender,
		$elm$core$List$minimum(lines));
	var newBaseline = A2(
		$elm$core$Maybe$withDefault,
		adjustment.baseline,
		$elm$core$List$minimum(
			A2(
				$elm$core$List$filter,
				function (x) {
					return !_Utils_eq(x, descender);
				},
				lines)));
	var base = lineHeight;
	var ascender = A2(
		$elm$core$Maybe$withDefault,
		adjustment.capital,
		$elm$core$List$maximum(lines));
	var capitalSize = 1 / (ascender - newBaseline);
	var capitalVertical = 1 - ascender;
	var fullSize = 1 / (ascender - descender);
	var fullVertical = 1 - ascender;
	var newCapitalMiddle = ((ascender - newBaseline) / 2) + newBaseline;
	var newFullMiddle = ((ascender - descender) / 2) + descender;
	return {
		capital: A3($mdgriffith$elm_ui$Internal$Model$adjust, capitalSize, ascender - newBaseline, capitalVertical),
		full: A3($mdgriffith$elm_ui$Internal$Model$adjust, fullSize, ascender - descender, fullVertical)
	};
};
var $mdgriffith$elm_ui$Internal$Model$fontAdjustmentRules = function (converted) {
	return _Utils_Tuple2(
		_List_fromArray(
			[
				_Utils_Tuple2('display', 'block')
			]),
		_List_fromArray(
			[
				_Utils_Tuple2('display', 'inline-block'),
				_Utils_Tuple2(
				'line-height',
				$elm$core$String$fromFloat(converted.height)),
				_Utils_Tuple2(
				'vertical-align',
				$elm$core$String$fromFloat(converted.vertical) + 'em'),
				_Utils_Tuple2(
				'font-size',
				$elm$core$String$fromFloat(converted.size) + 'em')
			]));
};
var $mdgriffith$elm_ui$Internal$Model$typefaceAdjustment = function (typefaces) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (face, found) {
				if (found.$ === 'Nothing') {
					if (face.$ === 'FontWith') {
						var _with = face.a;
						var _v2 = _with.adjustment;
						if (_v2.$ === 'Nothing') {
							return found;
						} else {
							var adjustment = _v2.a;
							return $elm$core$Maybe$Just(
								_Utils_Tuple2(
									$mdgriffith$elm_ui$Internal$Model$fontAdjustmentRules(
										function ($) {
											return $.full;
										}(
											$mdgriffith$elm_ui$Internal$Model$convertAdjustment(adjustment))),
									$mdgriffith$elm_ui$Internal$Model$fontAdjustmentRules(
										function ($) {
											return $.capital;
										}(
											$mdgriffith$elm_ui$Internal$Model$convertAdjustment(adjustment)))));
						}
					} else {
						return found;
					}
				} else {
					return found;
				}
			}),
		$elm$core$Maybe$Nothing,
		typefaces);
};
var $mdgriffith$elm_ui$Internal$Model$renderTopLevelValues = function (rules) {
	var withImport = function (font) {
		if (font.$ === 'ImportFont') {
			var url = font.b;
			return $elm$core$Maybe$Just('@import url(\'' + (url + '\');'));
		} else {
			return $elm$core$Maybe$Nothing;
		}
	};
	var fontImports = function (_v2) {
		var name = _v2.a;
		var typefaces = _v2.b;
		var imports = A2(
			$elm$core$String$join,
			'\n',
			A2($elm$core$List$filterMap, withImport, typefaces));
		return imports;
	};
	var allNames = A2($elm$core$List$map, $elm$core$Tuple$first, rules);
	var fontAdjustments = function (_v1) {
		var name = _v1.a;
		var typefaces = _v1.b;
		var _v0 = $mdgriffith$elm_ui$Internal$Model$typefaceAdjustment(typefaces);
		if (_v0.$ === 'Nothing') {
			return A2(
				$elm$core$String$join,
				'',
				A2(
					$elm$core$List$map,
					$mdgriffith$elm_ui$Internal$Model$renderNullAdjustmentRule(name),
					allNames));
		} else {
			var adjustment = _v0.a;
			return A2(
				$elm$core$String$join,
				'',
				A2(
					$elm$core$List$map,
					A2($mdgriffith$elm_ui$Internal$Model$renderFontAdjustmentRule, name, adjustment),
					allNames));
		}
	};
	return _Utils_ap(
		A2(
			$elm$core$String$join,
			'\n',
			A2($elm$core$List$map, fontImports, rules)),
		A2(
			$elm$core$String$join,
			'\n',
			A2($elm$core$List$map, fontAdjustments, rules)));
};
var $mdgriffith$elm_ui$Internal$Model$topLevelValue = function (rule) {
	if (rule.$ === 'FontFamily') {
		var name = rule.a;
		var typefaces = rule.b;
		return $elm$core$Maybe$Just(
			_Utils_Tuple2(name, typefaces));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $mdgriffith$elm_ui$Internal$Model$toStyleSheetString = F2(
	function (options, stylesheet) {
		var combine = F2(
			function (style, rendered) {
				return {
					rules: _Utils_ap(
						rendered.rules,
						A3($mdgriffith$elm_ui$Internal$Model$renderStyleRule, options, style, $elm$core$Maybe$Nothing)),
					topLevel: function () {
						var _v1 = $mdgriffith$elm_ui$Internal$Model$topLevelValue(style);
						if (_v1.$ === 'Nothing') {
							return rendered.topLevel;
						} else {
							var topLevel = _v1.a;
							return A2($elm$core$List$cons, topLevel, rendered.topLevel);
						}
					}()
				};
			});
		var _v0 = A3(
			$elm$core$List$foldl,
			combine,
			{rules: _List_Nil, topLevel: _List_Nil},
			stylesheet);
		var topLevel = _v0.topLevel;
		var rules = _v0.rules;
		return _Utils_ap(
			$mdgriffith$elm_ui$Internal$Model$renderTopLevelValues(topLevel),
			$elm$core$String$concat(rules));
	});
var $mdgriffith$elm_ui$Internal$Model$toStyleSheet = F2(
	function (options, styleSheet) {
		var _v0 = options.mode;
		switch (_v0.$) {
			case 'Layout':
				return A3(
					$elm$virtual_dom$VirtualDom$node,
					'div',
					_List_Nil,
					_List_fromArray(
						[
							A3(
							$elm$virtual_dom$VirtualDom$node,
							'style',
							_List_Nil,
							_List_fromArray(
								[
									$elm$virtual_dom$VirtualDom$text(
									A2($mdgriffith$elm_ui$Internal$Model$toStyleSheetString, options, styleSheet))
								]))
						]));
			case 'NoStaticStyleSheet':
				return A3(
					$elm$virtual_dom$VirtualDom$node,
					'div',
					_List_Nil,
					_List_fromArray(
						[
							A3(
							$elm$virtual_dom$VirtualDom$node,
							'style',
							_List_Nil,
							_List_fromArray(
								[
									$elm$virtual_dom$VirtualDom$text(
									A2($mdgriffith$elm_ui$Internal$Model$toStyleSheetString, options, styleSheet))
								]))
						]));
			default:
				return A3(
					$elm$virtual_dom$VirtualDom$node,
					'elm-ui-rules',
					_List_fromArray(
						[
							A2(
							$elm$virtual_dom$VirtualDom$property,
							'rules',
							A2($mdgriffith$elm_ui$Internal$Model$encodeStyles, options, styleSheet))
						]),
					_List_Nil);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$embedKeyed = F4(
	function (_static, opts, styles, children) {
		var dynamicStyleSheet = A2(
			$mdgriffith$elm_ui$Internal$Model$toStyleSheet,
			opts,
			A3(
				$elm$core$List$foldl,
				$mdgriffith$elm_ui$Internal$Model$reduceStyles,
				_Utils_Tuple2(
					$elm$core$Set$empty,
					$mdgriffith$elm_ui$Internal$Model$renderFocusStyle(opts.focus)),
				styles).b);
		return _static ? A2(
			$elm$core$List$cons,
			_Utils_Tuple2(
				'static-stylesheet',
				$mdgriffith$elm_ui$Internal$Model$staticRoot(opts)),
			A2(
				$elm$core$List$cons,
				_Utils_Tuple2('dynamic-stylesheet', dynamicStyleSheet),
				children)) : A2(
			$elm$core$List$cons,
			_Utils_Tuple2('dynamic-stylesheet', dynamicStyleSheet),
			children);
	});
var $mdgriffith$elm_ui$Internal$Model$embedWith = F4(
	function (_static, opts, styles, children) {
		var dynamicStyleSheet = A2(
			$mdgriffith$elm_ui$Internal$Model$toStyleSheet,
			opts,
			A3(
				$elm$core$List$foldl,
				$mdgriffith$elm_ui$Internal$Model$reduceStyles,
				_Utils_Tuple2(
					$elm$core$Set$empty,
					$mdgriffith$elm_ui$Internal$Model$renderFocusStyle(opts.focus)),
				styles).b);
		return _static ? A2(
			$elm$core$List$cons,
			$mdgriffith$elm_ui$Internal$Model$staticRoot(opts),
			A2($elm$core$List$cons, dynamicStyleSheet, children)) : A2($elm$core$List$cons, dynamicStyleSheet, children);
	});
var $mdgriffith$elm_ui$Internal$Flag$heightBetween = $mdgriffith$elm_ui$Internal$Flag$flag(45);
var $mdgriffith$elm_ui$Internal$Flag$heightFill = $mdgriffith$elm_ui$Internal$Flag$flag(37);
var $mdgriffith$elm_ui$Internal$Flag$present = F2(
	function (myFlag, _v0) {
		var fieldOne = _v0.a;
		var fieldTwo = _v0.b;
		if (myFlag.$ === 'Flag') {
			var first = myFlag.a;
			return _Utils_eq(first & fieldOne, first);
		} else {
			var second = myFlag.a;
			return _Utils_eq(second & fieldTwo, second);
		}
	});
var $elm$html$Html$s = _VirtualDom_node('s');
var $elm$html$Html$u = _VirtualDom_node('u');
var $mdgriffith$elm_ui$Internal$Flag$widthBetween = $mdgriffith$elm_ui$Internal$Flag$flag(44);
var $mdgriffith$elm_ui$Internal$Flag$widthFill = $mdgriffith$elm_ui$Internal$Flag$flag(39);
var $mdgriffith$elm_ui$Internal$Model$finalizeNode = F6(
	function (has, node, attributes, children, embedMode, parentContext) {
		var createNode = F2(
			function (nodeName, attrs) {
				if (children.$ === 'Keyed') {
					var keyed = children.a;
					return A3(
						$elm$virtual_dom$VirtualDom$keyedNode,
						nodeName,
						attrs,
						function () {
							switch (embedMode.$) {
								case 'NoStyleSheet':
									return keyed;
								case 'OnlyDynamic':
									var opts = embedMode.a;
									var styles = embedMode.b;
									return A4($mdgriffith$elm_ui$Internal$Model$embedKeyed, false, opts, styles, keyed);
								default:
									var opts = embedMode.a;
									var styles = embedMode.b;
									return A4($mdgriffith$elm_ui$Internal$Model$embedKeyed, true, opts, styles, keyed);
							}
						}());
				} else {
					var unkeyed = children.a;
					return A2(
						function () {
							switch (nodeName) {
								case 'div':
									return $elm$html$Html$div;
								case 'p':
									return $elm$html$Html$p;
								default:
									return $elm$virtual_dom$VirtualDom$node(nodeName);
							}
						}(),
						attrs,
						function () {
							switch (embedMode.$) {
								case 'NoStyleSheet':
									return unkeyed;
								case 'OnlyDynamic':
									var opts = embedMode.a;
									var styles = embedMode.b;
									return A4($mdgriffith$elm_ui$Internal$Model$embedWith, false, opts, styles, unkeyed);
								default:
									var opts = embedMode.a;
									var styles = embedMode.b;
									return A4($mdgriffith$elm_ui$Internal$Model$embedWith, true, opts, styles, unkeyed);
							}
						}());
				}
			});
		var html = function () {
			switch (node.$) {
				case 'Generic':
					return A2(createNode, 'div', attributes);
				case 'NodeName':
					var nodeName = node.a;
					return A2(createNode, nodeName, attributes);
				default:
					var nodeName = node.a;
					var internal = node.b;
					return A3(
						$elm$virtual_dom$VirtualDom$node,
						nodeName,
						attributes,
						_List_fromArray(
							[
								A2(
								createNode,
								internal,
								_List_fromArray(
									[
										$elm$html$Html$Attributes$class($mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.single))
									]))
							]));
			}
		}();
		switch (parentContext.$) {
			case 'AsRow':
				return (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$widthFill, has) && (!A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$widthBetween, has))) ? html : (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$alignRight, has) ? A2(
					$elm$html$Html$u,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class(
							A2(
								$elm$core$String$join,
								' ',
								_List_fromArray(
									[$mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.container, $mdgriffith$elm_ui$Internal$Style$classes.contentCenterY, $mdgriffith$elm_ui$Internal$Style$classes.alignContainerRight])))
						]),
					_List_fromArray(
						[html])) : (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$centerX, has) ? A2(
					$elm$html$Html$s,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class(
							A2(
								$elm$core$String$join,
								' ',
								_List_fromArray(
									[$mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.container, $mdgriffith$elm_ui$Internal$Style$classes.contentCenterY, $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX])))
						]),
					_List_fromArray(
						[html])) : html));
			case 'AsColumn':
				return (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$heightFill, has) && (!A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$heightBetween, has))) ? html : (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$centerY, has) ? A2(
					$elm$html$Html$s,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class(
							A2(
								$elm$core$String$join,
								' ',
								_List_fromArray(
									[$mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.container, $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY])))
						]),
					_List_fromArray(
						[html])) : (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$alignBottom, has) ? A2(
					$elm$html$Html$u,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class(
							A2(
								$elm$core$String$join,
								' ',
								_List_fromArray(
									[$mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.container, $mdgriffith$elm_ui$Internal$Style$classes.alignContainerBottom])))
						]),
					_List_fromArray(
						[html])) : html));
			default:
				return html;
		}
	});
var $mdgriffith$elm_ui$Internal$Model$textElementClasses = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.text + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.widthContent + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.heightContent)))));
var $mdgriffith$elm_ui$Internal$Model$textElement = function (str) {
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				$elm$html$Html$Attributes$class($mdgriffith$elm_ui$Internal$Model$textElementClasses)
			]),
		_List_fromArray(
			[
				$elm$html$Html$text(str)
			]));
};
var $mdgriffith$elm_ui$Internal$Model$textElementFillClasses = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.text + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.widthFill + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.heightFill)))));
var $mdgriffith$elm_ui$Internal$Model$textElementFill = function (str) {
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				$elm$html$Html$Attributes$class($mdgriffith$elm_ui$Internal$Model$textElementFillClasses)
			]),
		_List_fromArray(
			[
				$elm$html$Html$text(str)
			]));
};
var $mdgriffith$elm_ui$Internal$Model$createElement = F3(
	function (context, children, rendered) {
		var gatherKeyed = F2(
			function (_v8, _v9) {
				var key = _v8.a;
				var child = _v8.b;
				var htmls = _v9.a;
				var existingStyles = _v9.b;
				switch (child.$) {
					case 'Unstyled':
						var html = child.a;
						return _Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asParagraph) ? _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									html(context)),
								htmls),
							existingStyles) : _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									html(context)),
								htmls),
							existingStyles);
					case 'Styled':
						var styled = child.a;
						return _Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asParagraph) ? _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, context)),
								htmls),
							$elm$core$List$isEmpty(existingStyles) ? styled.styles : _Utils_ap(styled.styles, existingStyles)) : _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, context)),
								htmls),
							$elm$core$List$isEmpty(existingStyles) ? styled.styles : _Utils_ap(styled.styles, existingStyles));
					case 'Text':
						var str = child.a;
						return _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									_Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asEl) ? $mdgriffith$elm_ui$Internal$Model$textElementFill(str) : $mdgriffith$elm_ui$Internal$Model$textElement(str)),
								htmls),
							existingStyles);
					default:
						return _Utils_Tuple2(htmls, existingStyles);
				}
			});
		var gather = F2(
			function (child, _v6) {
				var htmls = _v6.a;
				var existingStyles = _v6.b;
				switch (child.$) {
					case 'Unstyled':
						var html = child.a;
						return _Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asParagraph) ? _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								html(context),
								htmls),
							existingStyles) : _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								html(context),
								htmls),
							existingStyles);
					case 'Styled':
						var styled = child.a;
						return _Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asParagraph) ? _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, context),
								htmls),
							$elm$core$List$isEmpty(existingStyles) ? styled.styles : _Utils_ap(styled.styles, existingStyles)) : _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, context),
								htmls),
							$elm$core$List$isEmpty(existingStyles) ? styled.styles : _Utils_ap(styled.styles, existingStyles));
					case 'Text':
						var str = child.a;
						return _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asEl) ? $mdgriffith$elm_ui$Internal$Model$textElementFill(str) : $mdgriffith$elm_ui$Internal$Model$textElement(str),
								htmls),
							existingStyles);
					default:
						return _Utils_Tuple2(htmls, existingStyles);
				}
			});
		if (children.$ === 'Keyed') {
			var keyedChildren = children.a;
			var _v1 = A3(
				$elm$core$List$foldr,
				gatherKeyed,
				_Utils_Tuple2(_List_Nil, _List_Nil),
				keyedChildren);
			var keyed = _v1.a;
			var styles = _v1.b;
			var newStyles = $elm$core$List$isEmpty(styles) ? rendered.styles : _Utils_ap(rendered.styles, styles);
			if (!newStyles.b) {
				return $mdgriffith$elm_ui$Internal$Model$Unstyled(
					A5(
						$mdgriffith$elm_ui$Internal$Model$finalizeNode,
						rendered.has,
						rendered.node,
						rendered.attributes,
						$mdgriffith$elm_ui$Internal$Model$Keyed(
							A3($mdgriffith$elm_ui$Internal$Model$addKeyedChildren, 'nearby-element-pls', keyed, rendered.children)),
						$mdgriffith$elm_ui$Internal$Model$NoStyleSheet));
			} else {
				var allStyles = newStyles;
				return $mdgriffith$elm_ui$Internal$Model$Styled(
					{
						html: A4(
							$mdgriffith$elm_ui$Internal$Model$finalizeNode,
							rendered.has,
							rendered.node,
							rendered.attributes,
							$mdgriffith$elm_ui$Internal$Model$Keyed(
								A3($mdgriffith$elm_ui$Internal$Model$addKeyedChildren, 'nearby-element-pls', keyed, rendered.children))),
						styles: allStyles
					});
			}
		} else {
			var unkeyedChildren = children.a;
			var _v3 = A3(
				$elm$core$List$foldr,
				gather,
				_Utils_Tuple2(_List_Nil, _List_Nil),
				unkeyedChildren);
			var unkeyed = _v3.a;
			var styles = _v3.b;
			var newStyles = $elm$core$List$isEmpty(styles) ? rendered.styles : _Utils_ap(rendered.styles, styles);
			if (!newStyles.b) {
				return $mdgriffith$elm_ui$Internal$Model$Unstyled(
					A5(
						$mdgriffith$elm_ui$Internal$Model$finalizeNode,
						rendered.has,
						rendered.node,
						rendered.attributes,
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							A2($mdgriffith$elm_ui$Internal$Model$addChildren, unkeyed, rendered.children)),
						$mdgriffith$elm_ui$Internal$Model$NoStyleSheet));
			} else {
				var allStyles = newStyles;
				return $mdgriffith$elm_ui$Internal$Model$Styled(
					{
						html: A4(
							$mdgriffith$elm_ui$Internal$Model$finalizeNode,
							rendered.has,
							rendered.node,
							rendered.attributes,
							$mdgriffith$elm_ui$Internal$Model$Unkeyed(
								A2($mdgriffith$elm_ui$Internal$Model$addChildren, unkeyed, rendered.children))),
						styles: allStyles
					});
			}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$Single = F3(
	function (a, b, c) {
		return {$: 'Single', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Internal$Model$Transform = function (a) {
	return {$: 'Transform', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$core$Bitwise$or = _Bitwise_or;
var $mdgriffith$elm_ui$Internal$Flag$add = F2(
	function (myFlag, _v0) {
		var one = _v0.a;
		var two = _v0.b;
		if (myFlag.$ === 'Flag') {
			var first = myFlag.a;
			return A2($mdgriffith$elm_ui$Internal$Flag$Field, first | one, two);
		} else {
			var second = myFlag.a;
			return A2($mdgriffith$elm_ui$Internal$Flag$Field, one, second | two);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$ChildrenBehind = function (a) {
	return {$: 'ChildrenBehind', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront = F2(
	function (a, b) {
		return {$: 'ChildrenBehindAndInFront', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$ChildrenInFront = function (a) {
	return {$: 'ChildrenInFront', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$nearbyElement = F2(
	function (location, elem) {
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$class(
					function () {
						switch (location.$) {
							case 'Above':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.above]));
							case 'Below':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.below]));
							case 'OnRight':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.onRight]));
							case 'OnLeft':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.onLeft]));
							case 'InFront':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.inFront]));
							default:
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.behind]));
						}
					}())
				]),
			_List_fromArray(
				[
					function () {
					switch (elem.$) {
						case 'Empty':
							return $elm$virtual_dom$VirtualDom$text('');
						case 'Text':
							var str = elem.a;
							return $mdgriffith$elm_ui$Internal$Model$textElement(str);
						case 'Unstyled':
							var html = elem.a;
							return html($mdgriffith$elm_ui$Internal$Model$asEl);
						default:
							var styled = elem.a;
							return A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, $mdgriffith$elm_ui$Internal$Model$asEl);
					}
				}()
				]));
	});
var $mdgriffith$elm_ui$Internal$Model$addNearbyElement = F3(
	function (location, elem, existing) {
		var nearby = A2($mdgriffith$elm_ui$Internal$Model$nearbyElement, location, elem);
		switch (existing.$) {
			case 'NoNearbyChildren':
				if (location.$ === 'Behind') {
					return $mdgriffith$elm_ui$Internal$Model$ChildrenBehind(
						_List_fromArray(
							[nearby]));
				} else {
					return $mdgriffith$elm_ui$Internal$Model$ChildrenInFront(
						_List_fromArray(
							[nearby]));
				}
			case 'ChildrenBehind':
				var existingBehind = existing.a;
				if (location.$ === 'Behind') {
					return $mdgriffith$elm_ui$Internal$Model$ChildrenBehind(
						A2($elm$core$List$cons, nearby, existingBehind));
				} else {
					return A2(
						$mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront,
						existingBehind,
						_List_fromArray(
							[nearby]));
				}
			case 'ChildrenInFront':
				var existingInFront = existing.a;
				if (location.$ === 'Behind') {
					return A2(
						$mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront,
						_List_fromArray(
							[nearby]),
						existingInFront);
				} else {
					return $mdgriffith$elm_ui$Internal$Model$ChildrenInFront(
						A2($elm$core$List$cons, nearby, existingInFront));
				}
			default:
				var existingBehind = existing.a;
				var existingInFront = existing.b;
				if (location.$ === 'Behind') {
					return A2(
						$mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront,
						A2($elm$core$List$cons, nearby, existingBehind),
						existingInFront);
				} else {
					return A2(
						$mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront,
						existingBehind,
						A2($elm$core$List$cons, nearby, existingInFront));
				}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$Embedded = F2(
	function (a, b) {
		return {$: 'Embedded', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$NodeName = function (a) {
	return {$: 'NodeName', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$addNodeName = F2(
	function (newNode, old) {
		switch (old.$) {
			case 'Generic':
				return $mdgriffith$elm_ui$Internal$Model$NodeName(newNode);
			case 'NodeName':
				var name = old.a;
				return A2($mdgriffith$elm_ui$Internal$Model$Embedded, name, newNode);
			default:
				var x = old.a;
				var y = old.b;
				return A2($mdgriffith$elm_ui$Internal$Model$Embedded, x, y);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$alignXName = function (align) {
	switch (align.$) {
		case 'Left':
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedHorizontally + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignLeft);
		case 'Right':
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedHorizontally + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignRight);
		default:
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedHorizontally + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignCenterX);
	}
};
var $mdgriffith$elm_ui$Internal$Model$alignYName = function (align) {
	switch (align.$) {
		case 'Top':
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedVertically + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignTop);
		case 'Bottom':
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedVertically + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignBottom);
		default:
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedVertically + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignCenterY);
	}
};
var $mdgriffith$elm_ui$Internal$Model$FullTransform = F4(
	function (a, b, c, d) {
		return {$: 'FullTransform', a: a, b: b, c: c, d: d};
	});
var $mdgriffith$elm_ui$Internal$Model$Moved = function (a) {
	return {$: 'Moved', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$composeTransformation = F2(
	function (transform, component) {
		switch (transform.$) {
			case 'Untransformed':
				switch (component.$) {
					case 'MoveX':
						var x = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(x, 0, 0));
					case 'MoveY':
						var y = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(0, y, 0));
					case 'MoveZ':
						var z = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(0, 0, z));
					case 'MoveXYZ':
						var xyz = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(xyz);
					case 'Rotate':
						var xyz = component.a;
						var angle = component.b;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(0, 0, 0),
							_Utils_Tuple3(1, 1, 1),
							xyz,
							angle);
					default:
						var xyz = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(0, 0, 0),
							xyz,
							_Utils_Tuple3(0, 0, 1),
							0);
				}
			case 'Moved':
				var moved = transform.a;
				var x = moved.a;
				var y = moved.b;
				var z = moved.c;
				switch (component.$) {
					case 'MoveX':
						var newX = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(newX, y, z));
					case 'MoveY':
						var newY = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(x, newY, z));
					case 'MoveZ':
						var newZ = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(x, y, newZ));
					case 'MoveXYZ':
						var xyz = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(xyz);
					case 'Rotate':
						var xyz = component.a;
						var angle = component.b;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							moved,
							_Utils_Tuple3(1, 1, 1),
							xyz,
							angle);
					default:
						var scale = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							moved,
							scale,
							_Utils_Tuple3(0, 0, 1),
							0);
				}
			default:
				var moved = transform.a;
				var x = moved.a;
				var y = moved.b;
				var z = moved.c;
				var scaled = transform.b;
				var origin = transform.c;
				var angle = transform.d;
				switch (component.$) {
					case 'MoveX':
						var newX = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(newX, y, z),
							scaled,
							origin,
							angle);
					case 'MoveY':
						var newY = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(x, newY, z),
							scaled,
							origin,
							angle);
					case 'MoveZ':
						var newZ = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(x, y, newZ),
							scaled,
							origin,
							angle);
					case 'MoveXYZ':
						var newMove = component.a;
						return A4($mdgriffith$elm_ui$Internal$Model$FullTransform, newMove, scaled, origin, angle);
					case 'Rotate':
						var newOrigin = component.a;
						var newAngle = component.b;
						return A4($mdgriffith$elm_ui$Internal$Model$FullTransform, moved, scaled, newOrigin, newAngle);
					default:
						var newScale = component.a;
						return A4($mdgriffith$elm_ui$Internal$Model$FullTransform, moved, newScale, origin, angle);
				}
		}
	});
var $mdgriffith$elm_ui$Internal$Flag$height = $mdgriffith$elm_ui$Internal$Flag$flag(7);
var $mdgriffith$elm_ui$Internal$Flag$heightContent = $mdgriffith$elm_ui$Internal$Flag$flag(36);
var $mdgriffith$elm_ui$Internal$Flag$merge = F2(
	function (_v0, _v1) {
		var one = _v0.a;
		var two = _v0.b;
		var three = _v1.a;
		var four = _v1.b;
		return A2($mdgriffith$elm_ui$Internal$Flag$Field, one | three, two | four);
	});
var $mdgriffith$elm_ui$Internal$Flag$none = A2($mdgriffith$elm_ui$Internal$Flag$Field, 0, 0);
var $mdgriffith$elm_ui$Internal$Model$renderHeight = function (h) {
	switch (h.$) {
		case 'Px':
			var px = h.a;
			var val = $elm$core$String$fromInt(px);
			var name = 'height-px-' + val;
			return _Utils_Tuple3(
				$mdgriffith$elm_ui$Internal$Flag$none,
				$mdgriffith$elm_ui$Internal$Style$classes.heightExact + (' ' + name),
				_List_fromArray(
					[
						A3($mdgriffith$elm_ui$Internal$Model$Single, name, 'height', val + 'px')
					]));
		case 'Content':
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightContent, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.heightContent,
				_List_Nil);
		case 'Fill':
			var portion = h.a;
			return (portion === 1) ? _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightFill, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.heightFill,
				_List_Nil) : _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightFill, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.heightFillPortion + (' height-fill-' + $elm$core$String$fromInt(portion)),
				_List_fromArray(
					[
						A3(
						$mdgriffith$elm_ui$Internal$Model$Single,
						$mdgriffith$elm_ui$Internal$Style$classes.any + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.column + (' > ' + $mdgriffith$elm_ui$Internal$Style$dot(
							'height-fill-' + $elm$core$String$fromInt(portion))))),
						'flex-grow',
						$elm$core$String$fromInt(portion * 100000))
					]));
		case 'Min':
			var minSize = h.a;
			var len = h.b;
			var cls = 'min-height-' + $elm$core$String$fromInt(minSize);
			var style = A3(
				$mdgriffith$elm_ui$Internal$Model$Single,
				cls,
				'min-height',
				$elm$core$String$fromInt(minSize) + 'px !important');
			var _v1 = $mdgriffith$elm_ui$Internal$Model$renderHeight(len);
			var newFlag = _v1.a;
			var newAttrs = _v1.b;
			var newStyle = _v1.c;
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightBetween, newFlag),
				cls + (' ' + newAttrs),
				A2($elm$core$List$cons, style, newStyle));
		default:
			var maxSize = h.a;
			var len = h.b;
			var cls = 'max-height-' + $elm$core$String$fromInt(maxSize);
			var style = A3(
				$mdgriffith$elm_ui$Internal$Model$Single,
				cls,
				'max-height',
				$elm$core$String$fromInt(maxSize) + 'px');
			var _v2 = $mdgriffith$elm_ui$Internal$Model$renderHeight(len);
			var newFlag = _v2.a;
			var newAttrs = _v2.b;
			var newStyle = _v2.c;
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightBetween, newFlag),
				cls + (' ' + newAttrs),
				A2($elm$core$List$cons, style, newStyle));
	}
};
var $mdgriffith$elm_ui$Internal$Flag$widthContent = $mdgriffith$elm_ui$Internal$Flag$flag(38);
var $mdgriffith$elm_ui$Internal$Model$renderWidth = function (w) {
	switch (w.$) {
		case 'Px':
			var px = w.a;
			return _Utils_Tuple3(
				$mdgriffith$elm_ui$Internal$Flag$none,
				$mdgriffith$elm_ui$Internal$Style$classes.widthExact + (' width-px-' + $elm$core$String$fromInt(px)),
				_List_fromArray(
					[
						A3(
						$mdgriffith$elm_ui$Internal$Model$Single,
						'width-px-' + $elm$core$String$fromInt(px),
						'width',
						$elm$core$String$fromInt(px) + 'px')
					]));
		case 'Content':
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthContent, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.widthContent,
				_List_Nil);
		case 'Fill':
			var portion = w.a;
			return (portion === 1) ? _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthFill, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.widthFill,
				_List_Nil) : _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthFill, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.widthFillPortion + (' width-fill-' + $elm$core$String$fromInt(portion)),
				_List_fromArray(
					[
						A3(
						$mdgriffith$elm_ui$Internal$Model$Single,
						$mdgriffith$elm_ui$Internal$Style$classes.any + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.row + (' > ' + $mdgriffith$elm_ui$Internal$Style$dot(
							'width-fill-' + $elm$core$String$fromInt(portion))))),
						'flex-grow',
						$elm$core$String$fromInt(portion * 100000))
					]));
		case 'Min':
			var minSize = w.a;
			var len = w.b;
			var cls = 'min-width-' + $elm$core$String$fromInt(minSize);
			var style = A3(
				$mdgriffith$elm_ui$Internal$Model$Single,
				cls,
				'min-width',
				$elm$core$String$fromInt(minSize) + 'px');
			var _v1 = $mdgriffith$elm_ui$Internal$Model$renderWidth(len);
			var newFlag = _v1.a;
			var newAttrs = _v1.b;
			var newStyle = _v1.c;
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthBetween, newFlag),
				cls + (' ' + newAttrs),
				A2($elm$core$List$cons, style, newStyle));
		default:
			var maxSize = w.a;
			var len = w.b;
			var cls = 'max-width-' + $elm$core$String$fromInt(maxSize);
			var style = A3(
				$mdgriffith$elm_ui$Internal$Model$Single,
				cls,
				'max-width',
				$elm$core$String$fromInt(maxSize) + 'px');
			var _v2 = $mdgriffith$elm_ui$Internal$Model$renderWidth(len);
			var newFlag = _v2.a;
			var newAttrs = _v2.b;
			var newStyle = _v2.c;
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthBetween, newFlag),
				cls + (' ' + newAttrs),
				A2($elm$core$List$cons, style, newStyle));
	}
};
var $mdgriffith$elm_ui$Internal$Flag$borderWidth = $mdgriffith$elm_ui$Internal$Flag$flag(27);
var $mdgriffith$elm_ui$Internal$Model$skippable = F2(
	function (flag, style) {
		if (_Utils_eq(flag, $mdgriffith$elm_ui$Internal$Flag$borderWidth)) {
			if (style.$ === 'Single') {
				var val = style.c;
				switch (val) {
					case '0px':
						return true;
					case '1px':
						return true;
					case '2px':
						return true;
					case '3px':
						return true;
					case '4px':
						return true;
					case '5px':
						return true;
					case '6px':
						return true;
					default:
						return false;
				}
			} else {
				return false;
			}
		} else {
			switch (style.$) {
				case 'FontSize':
					var i = style.a;
					return (i >= 8) && (i <= 32);
				case 'PaddingStyle':
					var name = style.a;
					var t = style.b;
					var r = style.c;
					var b = style.d;
					var l = style.e;
					return _Utils_eq(t, b) && (_Utils_eq(t, r) && (_Utils_eq(t, l) && ((t >= 0) && (t <= 24))));
				default:
					return false;
			}
		}
	});
var $mdgriffith$elm_ui$Internal$Flag$width = $mdgriffith$elm_ui$Internal$Flag$flag(6);
var $mdgriffith$elm_ui$Internal$Flag$xAlign = $mdgriffith$elm_ui$Internal$Flag$flag(30);
var $mdgriffith$elm_ui$Internal$Flag$yAlign = $mdgriffith$elm_ui$Internal$Flag$flag(29);
var $mdgriffith$elm_ui$Internal$Model$gatherAttrRecursive = F8(
	function (classes, node, has, transform, styles, attrs, children, elementAttrs) {
		gatherAttrRecursive:
		while (true) {
			if (!elementAttrs.b) {
				var _v1 = $mdgriffith$elm_ui$Internal$Model$transformClass(transform);
				if (_v1.$ === 'Nothing') {
					return {
						attributes: A2(
							$elm$core$List$cons,
							$elm$html$Html$Attributes$class(classes),
							attrs),
						children: children,
						has: has,
						node: node,
						styles: styles
					};
				} else {
					var _class = _v1.a;
					return {
						attributes: A2(
							$elm$core$List$cons,
							$elm$html$Html$Attributes$class(classes + (' ' + _class)),
							attrs),
						children: children,
						has: has,
						node: node,
						styles: A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$Transform(transform),
							styles)
					};
				}
			} else {
				var attribute = elementAttrs.a;
				var remaining = elementAttrs.b;
				switch (attribute.$) {
					case 'NoAttribute':
						var $temp$classes = classes,
							$temp$node = node,
							$temp$has = has,
							$temp$transform = transform,
							$temp$styles = styles,
							$temp$attrs = attrs,
							$temp$children = children,
							$temp$elementAttrs = remaining;
						classes = $temp$classes;
						node = $temp$node;
						has = $temp$has;
						transform = $temp$transform;
						styles = $temp$styles;
						attrs = $temp$attrs;
						children = $temp$children;
						elementAttrs = $temp$elementAttrs;
						continue gatherAttrRecursive;
					case 'Class':
						var flag = attribute.a;
						var exactClassName = attribute.b;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, flag, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							var $temp$classes = exactClassName + (' ' + classes),
								$temp$node = node,
								$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, flag, has),
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						}
					case 'Attr':
						var actualAttribute = attribute.a;
						var $temp$classes = classes,
							$temp$node = node,
							$temp$has = has,
							$temp$transform = transform,
							$temp$styles = styles,
							$temp$attrs = A2($elm$core$List$cons, actualAttribute, attrs),
							$temp$children = children,
							$temp$elementAttrs = remaining;
						classes = $temp$classes;
						node = $temp$node;
						has = $temp$has;
						transform = $temp$transform;
						styles = $temp$styles;
						attrs = $temp$attrs;
						children = $temp$children;
						elementAttrs = $temp$elementAttrs;
						continue gatherAttrRecursive;
					case 'StyleClass':
						var flag = attribute.a;
						var style = attribute.b;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, flag, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							if (A2($mdgriffith$elm_ui$Internal$Model$skippable, flag, style)) {
								var $temp$classes = $mdgriffith$elm_ui$Internal$Model$getStyleName(style) + (' ' + classes),
									$temp$node = node,
									$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, flag, has),
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							} else {
								var $temp$classes = $mdgriffith$elm_ui$Internal$Model$getStyleName(style) + (' ' + classes),
									$temp$node = node,
									$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, flag, has),
									$temp$transform = transform,
									$temp$styles = A2($elm$core$List$cons, style, styles),
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							}
						}
					case 'TransformComponent':
						var flag = attribute.a;
						var component = attribute.b;
						var $temp$classes = classes,
							$temp$node = node,
							$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, flag, has),
							$temp$transform = A2($mdgriffith$elm_ui$Internal$Model$composeTransformation, transform, component),
							$temp$styles = styles,
							$temp$attrs = attrs,
							$temp$children = children,
							$temp$elementAttrs = remaining;
						classes = $temp$classes;
						node = $temp$node;
						has = $temp$has;
						transform = $temp$transform;
						styles = $temp$styles;
						attrs = $temp$attrs;
						children = $temp$children;
						elementAttrs = $temp$elementAttrs;
						continue gatherAttrRecursive;
					case 'Width':
						var width = attribute.a;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$width, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							switch (width.$) {
								case 'Px':
									var px = width.a;
									var $temp$classes = ($mdgriffith$elm_ui$Internal$Style$classes.widthExact + (' width-px-' + $elm$core$String$fromInt(px))) + (' ' + classes),
										$temp$node = node,
										$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has),
										$temp$transform = transform,
										$temp$styles = A2(
										$elm$core$List$cons,
										A3(
											$mdgriffith$elm_ui$Internal$Model$Single,
											'width-px-' + $elm$core$String$fromInt(px),
											'width',
											$elm$core$String$fromInt(px) + 'px'),
										styles),
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								case 'Content':
									var $temp$classes = classes + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.widthContent),
										$temp$node = node,
										$temp$has = A2(
										$mdgriffith$elm_ui$Internal$Flag$add,
										$mdgriffith$elm_ui$Internal$Flag$widthContent,
										A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has)),
										$temp$transform = transform,
										$temp$styles = styles,
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								case 'Fill':
									var portion = width.a;
									if (portion === 1) {
										var $temp$classes = classes + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.widthFill),
											$temp$node = node,
											$temp$has = A2(
											$mdgriffith$elm_ui$Internal$Flag$add,
											$mdgriffith$elm_ui$Internal$Flag$widthFill,
											A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has)),
											$temp$transform = transform,
											$temp$styles = styles,
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									} else {
										var $temp$classes = classes + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.widthFillPortion + (' width-fill-' + $elm$core$String$fromInt(portion)))),
											$temp$node = node,
											$temp$has = A2(
											$mdgriffith$elm_ui$Internal$Flag$add,
											$mdgriffith$elm_ui$Internal$Flag$widthFill,
											A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has)),
											$temp$transform = transform,
											$temp$styles = A2(
											$elm$core$List$cons,
											A3(
												$mdgriffith$elm_ui$Internal$Model$Single,
												$mdgriffith$elm_ui$Internal$Style$classes.any + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.row + (' > ' + $mdgriffith$elm_ui$Internal$Style$dot(
													'width-fill-' + $elm$core$String$fromInt(portion))))),
												'flex-grow',
												$elm$core$String$fromInt(portion * 100000)),
											styles),
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									}
								default:
									var _v4 = $mdgriffith$elm_ui$Internal$Model$renderWidth(width);
									var addToFlags = _v4.a;
									var newClass = _v4.b;
									var newStyles = _v4.c;
									var $temp$classes = classes + (' ' + newClass),
										$temp$node = node,
										$temp$has = A2(
										$mdgriffith$elm_ui$Internal$Flag$merge,
										addToFlags,
										A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has)),
										$temp$transform = transform,
										$temp$styles = _Utils_ap(newStyles, styles),
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
							}
						}
					case 'Height':
						var height = attribute.a;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$height, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							switch (height.$) {
								case 'Px':
									var px = height.a;
									var val = $elm$core$String$fromInt(px) + 'px';
									var name = 'height-px-' + val;
									var $temp$classes = $mdgriffith$elm_ui$Internal$Style$classes.heightExact + (' ' + (name + (' ' + classes))),
										$temp$node = node,
										$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has),
										$temp$transform = transform,
										$temp$styles = A2(
										$elm$core$List$cons,
										A3($mdgriffith$elm_ui$Internal$Model$Single, name, 'height ', val),
										styles),
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								case 'Content':
									var $temp$classes = $mdgriffith$elm_ui$Internal$Style$classes.heightContent + (' ' + classes),
										$temp$node = node,
										$temp$has = A2(
										$mdgriffith$elm_ui$Internal$Flag$add,
										$mdgriffith$elm_ui$Internal$Flag$heightContent,
										A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has)),
										$temp$transform = transform,
										$temp$styles = styles,
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								case 'Fill':
									var portion = height.a;
									if (portion === 1) {
										var $temp$classes = $mdgriffith$elm_ui$Internal$Style$classes.heightFill + (' ' + classes),
											$temp$node = node,
											$temp$has = A2(
											$mdgriffith$elm_ui$Internal$Flag$add,
											$mdgriffith$elm_ui$Internal$Flag$heightFill,
											A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has)),
											$temp$transform = transform,
											$temp$styles = styles,
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									} else {
										var $temp$classes = classes + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.heightFillPortion + (' height-fill-' + $elm$core$String$fromInt(portion)))),
											$temp$node = node,
											$temp$has = A2(
											$mdgriffith$elm_ui$Internal$Flag$add,
											$mdgriffith$elm_ui$Internal$Flag$heightFill,
											A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has)),
											$temp$transform = transform,
											$temp$styles = A2(
											$elm$core$List$cons,
											A3(
												$mdgriffith$elm_ui$Internal$Model$Single,
												$mdgriffith$elm_ui$Internal$Style$classes.any + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.column + (' > ' + $mdgriffith$elm_ui$Internal$Style$dot(
													'height-fill-' + $elm$core$String$fromInt(portion))))),
												'flex-grow',
												$elm$core$String$fromInt(portion * 100000)),
											styles),
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									}
								default:
									var _v6 = $mdgriffith$elm_ui$Internal$Model$renderHeight(height);
									var addToFlags = _v6.a;
									var newClass = _v6.b;
									var newStyles = _v6.c;
									var $temp$classes = classes + (' ' + newClass),
										$temp$node = node,
										$temp$has = A2(
										$mdgriffith$elm_ui$Internal$Flag$merge,
										addToFlags,
										A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has)),
										$temp$transform = transform,
										$temp$styles = _Utils_ap(newStyles, styles),
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
							}
						}
					case 'Describe':
						var description = attribute.a;
						switch (description.$) {
							case 'Main':
								var $temp$classes = classes,
									$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'main', node),
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Navigation':
								var $temp$classes = classes,
									$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'nav', node),
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'ContentInfo':
								var $temp$classes = classes,
									$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'footer', node),
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Complementary':
								var $temp$classes = classes,
									$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'aside', node),
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Heading':
								var i = description.a;
								if (i <= 1) {
									var $temp$classes = classes,
										$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'h1', node),
										$temp$has = has,
										$temp$transform = transform,
										$temp$styles = styles,
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								} else {
									if (i < 7) {
										var $temp$classes = classes,
											$temp$node = A2(
											$mdgriffith$elm_ui$Internal$Model$addNodeName,
											'h' + $elm$core$String$fromInt(i),
											node),
											$temp$has = has,
											$temp$transform = transform,
											$temp$styles = styles,
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									} else {
										var $temp$classes = classes,
											$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'h6', node),
											$temp$has = has,
											$temp$transform = transform,
											$temp$styles = styles,
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									}
								}
							case 'Paragraph':
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Button':
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = A2(
									$elm$core$List$cons,
									A2($elm$virtual_dom$VirtualDom$attribute, 'role', 'button'),
									attrs),
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Label':
								var label = description.a;
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = A2(
									$elm$core$List$cons,
									A2($elm$virtual_dom$VirtualDom$attribute, 'aria-label', label),
									attrs),
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'LivePolite':
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = A2(
									$elm$core$List$cons,
									A2($elm$virtual_dom$VirtualDom$attribute, 'aria-live', 'polite'),
									attrs),
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							default:
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = A2(
									$elm$core$List$cons,
									A2($elm$virtual_dom$VirtualDom$attribute, 'aria-live', 'assertive'),
									attrs),
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
						}
					case 'Nearby':
						var location = attribute.a;
						var elem = attribute.b;
						var newStyles = function () {
							switch (elem.$) {
								case 'Empty':
									return styles;
								case 'Text':
									var str = elem.a;
									return styles;
								case 'Unstyled':
									var html = elem.a;
									return styles;
								default:
									var styled = elem.a;
									return _Utils_ap(styles, styled.styles);
							}
						}();
						var $temp$classes = classes,
							$temp$node = node,
							$temp$has = has,
							$temp$transform = transform,
							$temp$styles = newStyles,
							$temp$attrs = attrs,
							$temp$children = A3($mdgriffith$elm_ui$Internal$Model$addNearbyElement, location, elem, children),
							$temp$elementAttrs = remaining;
						classes = $temp$classes;
						node = $temp$node;
						has = $temp$has;
						transform = $temp$transform;
						styles = $temp$styles;
						attrs = $temp$attrs;
						children = $temp$children;
						elementAttrs = $temp$elementAttrs;
						continue gatherAttrRecursive;
					case 'AlignX':
						var x = attribute.a;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$xAlign, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							var $temp$classes = $mdgriffith$elm_ui$Internal$Model$alignXName(x) + (' ' + classes),
								$temp$node = node,
								$temp$has = function (flags) {
								switch (x.$) {
									case 'CenterX':
										return A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$centerX, flags);
									case 'Right':
										return A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$alignRight, flags);
									default:
										return flags;
								}
							}(
								A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$xAlign, has)),
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						}
					default:
						var y = attribute.a;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$yAlign, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							var $temp$classes = $mdgriffith$elm_ui$Internal$Model$alignYName(y) + (' ' + classes),
								$temp$node = node,
								$temp$has = function (flags) {
								switch (y.$) {
									case 'CenterY':
										return A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$centerY, flags);
									case 'Bottom':
										return A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$alignBottom, flags);
									default:
										return flags;
								}
							}(
								A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$yAlign, has)),
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						}
				}
			}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$Untransformed = {$: 'Untransformed'};
var $mdgriffith$elm_ui$Internal$Model$untransformed = $mdgriffith$elm_ui$Internal$Model$Untransformed;
var $mdgriffith$elm_ui$Internal$Model$element = F4(
	function (context, node, attributes, children) {
		return A3(
			$mdgriffith$elm_ui$Internal$Model$createElement,
			context,
			children,
			A8(
				$mdgriffith$elm_ui$Internal$Model$gatherAttrRecursive,
				$mdgriffith$elm_ui$Internal$Model$contextClasses(context),
				node,
				$mdgriffith$elm_ui$Internal$Flag$none,
				$mdgriffith$elm_ui$Internal$Model$untransformed,
				_List_Nil,
				_List_Nil,
				$mdgriffith$elm_ui$Internal$Model$NoNearbyChildren,
				$elm$core$List$reverse(attributes)));
	});
var $mdgriffith$elm_ui$Internal$Model$Height = function (a) {
	return {$: 'Height', a: a};
};
var $mdgriffith$elm_ui$Element$height = $mdgriffith$elm_ui$Internal$Model$Height;
var $mdgriffith$elm_ui$Internal$Model$Attr = function (a) {
	return {$: 'Attr', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$htmlClass = function (cls) {
	return $mdgriffith$elm_ui$Internal$Model$Attr(
		$elm$html$Html$Attributes$class(cls));
};
var $mdgriffith$elm_ui$Internal$Model$Content = {$: 'Content'};
var $mdgriffith$elm_ui$Element$shrink = $mdgriffith$elm_ui$Internal$Model$Content;
var $mdgriffith$elm_ui$Internal$Model$Width = function (a) {
	return {$: 'Width', a: a};
};
var $mdgriffith$elm_ui$Element$width = $mdgriffith$elm_ui$Internal$Model$Width;
var $mdgriffith$elm_ui$Element$column = F2(
	function (attrs, children) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asColumn,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentTop + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.contentLeft)),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
						attrs))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
	});
var $mdgriffith$elm_ui$Internal$Model$Fill = function (a) {
	return {$: 'Fill', a: a};
};
var $mdgriffith$elm_ui$Element$fill = $mdgriffith$elm_ui$Internal$Model$Fill(1);
var $mdgriffith$elm_ui$Element$fillPortion = $mdgriffith$elm_ui$Internal$Model$Fill;
var $mdgriffith$elm_ui$Internal$Model$Rgba = F4(
	function (a, b, c, d) {
		return {$: 'Rgba', a: a, b: b, c: c, d: d};
	});
var $mdgriffith$elm_ui$Element$rgb255 = F3(
	function (red, green, blue) {
		return A4($mdgriffith$elm_ui$Internal$Model$Rgba, red / 255, green / 255, blue / 255, 1);
	});
var $author$project$Colors$greyscaleGray = A3($mdgriffith$elm_ui$Element$rgb255, 136, 136, 136);
var $author$project$Colors$greyscaleOuterSpace = A3($mdgriffith$elm_ui$Element$rgb255, 43, 47, 48);
var $author$project$Colors$navText = $author$project$Colors$greyscaleOuterSpace;
var $author$project$Colors$cerulean = A3($mdgriffith$elm_ui$Element$rgb255, 18, 178, 231);
var $author$project$Colors$brandPrimary = $author$project$Colors$cerulean;
var $author$project$Colors$kodi = $author$project$Colors$brandPrimary;
var $author$project$Colors$navTextHover = $author$project$Colors$kodi;
var $author$project$Components$VerticalNav$isCurrentRoute = F2(
	function (route, currentRoute) {
		return _Utils_eq(route, currentRoute) ? $mdgriffith$elm_ui$Element$Font$color($author$project$Colors$navTextHover) : $mdgriffith$elm_ui$Element$Font$color($author$project$Colors$navText);
	});
var $elm$html$Html$Attributes$rel = _VirtualDom_attribute('rel');
var $mdgriffith$elm_ui$Element$link = F2(
	function (attrs, _v0) {
		var url = _v0.url;
		var label = _v0.label;
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			$mdgriffith$elm_ui$Internal$Model$NodeName('a'),
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$Attr(
					$elm$html$Html$Attributes$href(url)),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Internal$Model$Attr(
						$elm$html$Html$Attributes$rel('noopener noreferrer')),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
							A2(
								$elm$core$List$cons,
								$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentCenterX + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.link)))),
								attrs))))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(
				_List_fromArray(
					[label])));
	});
var $elm$core$List$member = F2(
	function (x, xs) {
		return A2(
			$elm$core$List$any,
			function (a) {
				return _Utils_eq(a, x);
			},
			xs);
	});
var $mdgriffith$elm_ui$Internal$Model$PaddingStyle = F5(
	function (a, b, c, d, e) {
		return {$: 'PaddingStyle', a: a, b: b, c: c, d: d, e: e};
	});
var $mdgriffith$elm_ui$Internal$Flag$padding = $mdgriffith$elm_ui$Internal$Flag$flag(2);
var $mdgriffith$elm_ui$Element$paddingXY = F2(
	function (x, y) {
		if (_Utils_eq(x, y)) {
			var f = x;
			return A2(
				$mdgriffith$elm_ui$Internal$Model$StyleClass,
				$mdgriffith$elm_ui$Internal$Flag$padding,
				A5(
					$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
					'p-' + $elm$core$String$fromInt(x),
					f,
					f,
					f,
					f));
		} else {
			var yFloat = y;
			var xFloat = x;
			return A2(
				$mdgriffith$elm_ui$Internal$Model$StyleClass,
				$mdgriffith$elm_ui$Internal$Flag$padding,
				A5(
					$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
					'p-' + ($elm$core$String$fromInt(x) + ('-' + $elm$core$String$fromInt(y))),
					yFloat,
					xFloat,
					yFloat,
					xFloat));
		}
	});
var $author$project$Colors$sidebar = A3($mdgriffith$elm_ui$Element$rgb255, 242, 242, 242);
var $mdgriffith$elm_ui$Internal$Model$SpacingStyle = F3(
	function (a, b, c) {
		return {$: 'SpacingStyle', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Internal$Flag$spacing = $mdgriffith$elm_ui$Internal$Flag$flag(3);
var $mdgriffith$elm_ui$Internal$Model$spacingName = F2(
	function (x, y) {
		return 'spacing-' + ($elm$core$String$fromInt(x) + ('-' + $elm$core$String$fromInt(y)));
	});
var $mdgriffith$elm_ui$Element$spacing = function (x) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$spacing,
		A3(
			$mdgriffith$elm_ui$Internal$Model$SpacingStyle,
			A2($mdgriffith$elm_ui$Internal$Model$spacingName, x, x),
			x,
			x));
};
var $mdgriffith$elm_ui$Internal$Model$Text = function (a) {
	return {$: 'Text', a: a};
};
var $mdgriffith$elm_ui$Element$text = function (content) {
	return $mdgriffith$elm_ui$Internal$Model$Text(content);
};
var $elm$core$String$append = _String_append;
var $author$project$Spa$Generated$Route$toString = function (route) {
	var segments = function () {
		switch (route.$) {
			case 'Top':
				return _List_Nil;
			case 'Addons':
				return _List_fromArray(
					['addons']);
			case 'Browser':
				return _List_fromArray(
					['browser']);
			case 'Help':
				return _List_fromArray(
					['help']);
			case 'Lab':
				return _List_fromArray(
					['lab']);
			case 'Movies':
				return _List_fromArray(
					['movies']);
			case 'Music':
				return _List_fromArray(
					['music']);
			case 'NotFound':
				return _List_fromArray(
					['not-found']);
			case 'Playlists':
				return _List_fromArray(
					['playlists']);
			case 'Thumbsup':
				return _List_fromArray(
					['thumbsup']);
			case 'Tvshows':
				return _List_fromArray(
					['tvshows']);
			case 'Movies__Recent':
				return _List_fromArray(
					['movies', 'recent']);
			case 'Music__Albums':
				return _List_fromArray(
					['music', 'albums']);
			case 'Music__Artists':
				return _List_fromArray(
					['music', 'artists']);
			case 'Music__Genres':
				return _List_fromArray(
					['music', 'genres']);
			case 'Music__Videos':
				return _List_fromArray(
					['music', 'videos']);
			case 'Settings__Addons':
				return _List_fromArray(
					['settings', 'addons']);
			case 'Settings__Nav':
				return _List_fromArray(
					['settings', 'nav']);
			case 'Settings__Search':
				return _List_fromArray(
					['settings', 'search']);
			case 'Settings__Web':
				return _List_fromArray(
					['settings', 'web']);
			case 'Tvshows__Recent':
				return _List_fromArray(
					['tvshows', 'recent']);
			case 'Browser__Source_String':
				var source = route.a.source;
				return _List_fromArray(
					['browser', source]);
			case 'Playlists__Name_String':
				var name = route.a.name;
				return _List_fromArray(
					['playlists', name]);
			case 'Videoplayer__Movieid_Int':
				var movieid = route.a.movieid;
				return _List_fromArray(
					[
						'videoplayer',
						$elm$core$String$fromInt(movieid)
					]);
			case 'Music__Top__Top':
				return _List_fromArray(
					['music', 'top']);
			case 'Settings__Kodi__Games':
				return _List_fromArray(
					['settings', 'kodi', 'games']);
			case 'Settings__Kodi__Interface':
				return _List_fromArray(
					['settings', 'kodi', 'interface']);
			case 'Settings__Kodi__Media':
				return _List_fromArray(
					['settings', 'kodi', 'media']);
			case 'Settings__Kodi__Player':
				return _List_fromArray(
					['settings', 'kodi', 'player']);
			case 'Settings__Kodi__Pvr':
				return _List_fromArray(
					['settings', 'kodi', 'pvr']);
			case 'Settings__Kodi__Services':
				return _List_fromArray(
					['settings', 'kodi', 'services']);
			case 'Settings__Kodi__System':
				return _List_fromArray(
					['settings', 'kodi', 'system']);
			case 'Music__Album__Albumid_Int':
				var albumid = route.a.albumid;
				return _List_fromArray(
					[
						'music',
						'album',
						$elm$core$String$fromInt(albumid)
					]);
			case 'Music__Artist__Artistid_Int':
				var artistid = route.a.artistid;
				return _List_fromArray(
					[
						'music',
						'artist',
						$elm$core$String$fromInt(artistid)
					]);
			default:
				var genre = route.a.genre;
				return _List_fromArray(
					['music', 'genre', genre]);
		}
	}();
	return A2(
		$elm$core$String$append,
		'/',
		A2($elm$core$String$join, '/', segments));
};
var $elm$core$String$toUpper = _String_toUpper;
var $author$project$Components$VerticalNav$view = F4(
	function (header, currentRoute, links, listPagesWithFilter) {
		var _v0 = A2($elm$core$List$member, currentRoute, listPagesWithFilter);
		if (!_v0) {
			return A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width(
						$mdgriffith$elm_ui$Element$fillPortion(1)),
						A2($mdgriffith$elm_ui$Element$paddingXY, 16, 8),
						$mdgriffith$elm_ui$Element$spacing(16),
						$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$greyscaleGray),
						$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$sidebar)
					]),
				_Utils_ap(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$text(
							$elm$core$String$toUpper(header))
						]),
					A2(
						$elm$core$List$map,
						function (a) {
							return A2(
								$mdgriffith$elm_ui$Element$link,
								_List_fromArray(
									[
										A2($author$project$Components$VerticalNav$isCurrentRoute, a.route, currentRoute),
										A2($mdgriffith$elm_ui$Element$paddingXY, 16, 0)
									]),
								{
									label: $mdgriffith$elm_ui$Element$text(a.label),
									url: $author$project$Spa$Generated$Route$toString(a.route)
								});
						},
						links)));
		} else {
			return A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width(
						$mdgriffith$elm_ui$Element$fillPortion(1)),
						$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$greyscaleGray),
						$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$sidebar)
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
								A2($mdgriffith$elm_ui$Element$paddingXY, 16, 8),
								$mdgriffith$elm_ui$Element$spacing(16)
							]),
						_Utils_ap(
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$text(
									$elm$core$String$toUpper(header))
								]),
							A2(
								$elm$core$List$map,
								function (a) {
									return A2(
										$mdgriffith$elm_ui$Element$link,
										_List_fromArray(
											[
												A2($author$project$Components$VerticalNav$isCurrentRoute, a.route, currentRoute),
												A2($mdgriffith$elm_ui$Element$paddingXY, 16, 0)
											]),
										{
											label: $mdgriffith$elm_ui$Element$text(a.label),
											url: $author$project$Spa$Generated$Route$toString(a.route)
										});
								},
								links))),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
								A2($mdgriffith$elm_ui$Element$paddingXY, 16, 8),
								$mdgriffith$elm_ui$Element$spacing(16)
							]),
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$text('FILTERS')
							])),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
								A2($mdgriffith$elm_ui$Element$paddingXY, 16, 8),
								$mdgriffith$elm_ui$Element$spacing(16)
							]),
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$text('SORT')
							]))
					]));
		}
	});
var $author$project$Pages$Browser$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A4(
				$author$project$Components$VerticalNav$view,
				'sources',
				model.route,
				A2(
					$elm$core$List$map,
					function (source) {
						return {
							label: source.label,
							route: $author$project$Spa$Generated$Route$Browser__Source_String(
								{
									source: $elm$url$Url$percentEncode(source.file)
								})
						};
					},
					model.source_list),
				_List_Nil)
			]),
		title: 'Browser'
	};
};
var $author$project$Pages$Browser$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Browser$init, load: $author$project$Pages$Browser$load, save: $author$project$Pages$Browser$save, subscriptions: $author$project$Pages$Browser$subscriptions, update: $author$project$Pages$Browser$update, view: $author$project$Pages$Browser$view});
var $author$project$Pages$Browser$Source_String$parseSource = function (string) {
	if (string.$ === 'Nothing') {
		return 'None';
	} else {
		var str = string.a;
		return str;
	}
};
var $author$project$Shared$sendAction = function (json) {
	return $author$project$Shared$sendActions(
		_List_fromArray(
			[json]));
};
var $author$project$Pages$Browser$Source_String$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{
				files: shared.file_list,
				route: $author$project$Spa$Generated$Route$Top,
				source: $author$project$Pages$Browser$Source_String$parseSource(
					$elm$url$Url$percentDecode(params.source)),
				source_list: shared.source_list
			},
			$author$project$Shared$sendAction(
				'{"jsonrpc":"2.0","method":"Files.GetDirectory","id":"1","params":{"directory":\"' + ($author$project$Pages$Browser$Source_String$parseSource(
					$elm$url$Url$percentDecode(params.source)) + '\","media":"files"}}')));
	});
var $author$project$Pages$Browser$Source_String$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			{files: shared.file_list, route: model.route, source: model.source, source_list: shared.source_list},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Browser$Source_String$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Browser$Source_String$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Browser$Source_String$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $mdgriffith$elm_ui$Element$el = F2(
	function (attrs, child) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
					attrs)),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(
				_List_fromArray(
					[child])));
	});
var $author$project$Colors$greyscaleDustGray = A3($mdgriffith$elm_ui$Element$rgb255, 153, 153, 153);
var $mdgriffith$elm_ui$Internal$Model$Hover = {$: 'Hover'};
var $mdgriffith$elm_ui$Internal$Model$PseudoSelector = F2(
	function (a, b) {
		return {$: 'PseudoSelector', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Flag$hover = $mdgriffith$elm_ui$Internal$Flag$flag(33);
var $mdgriffith$elm_ui$Internal$Model$AlignX = function (a) {
	return {$: 'AlignX', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$AlignY = function (a) {
	return {$: 'AlignY', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$Class = F2(
	function (a, b) {
		return {$: 'Class', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$Describe = function (a) {
	return {$: 'Describe', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$Nearby = F2(
	function (a, b) {
		return {$: 'Nearby', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$NoAttribute = {$: 'NoAttribute'};
var $mdgriffith$elm_ui$Internal$Model$TransformComponent = F2(
	function (a, b) {
		return {$: 'TransformComponent', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$Empty = {$: 'Empty'};
var $mdgriffith$elm_ui$Internal$Model$map = F2(
	function (fn, el) {
		switch (el.$) {
			case 'Styled':
				var styled = el.a;
				return $mdgriffith$elm_ui$Internal$Model$Styled(
					{
						html: F2(
							function (add, context) {
								return A2(
									$elm$virtual_dom$VirtualDom$map,
									fn,
									A2(styled.html, add, context));
							}),
						styles: styled.styles
					});
			case 'Unstyled':
				var html = el.a;
				return $mdgriffith$elm_ui$Internal$Model$Unstyled(
					A2(
						$elm$core$Basics$composeL,
						$elm$virtual_dom$VirtualDom$map(fn),
						html));
			case 'Text':
				var str = el.a;
				return $mdgriffith$elm_ui$Internal$Model$Text(str);
			default:
				return $mdgriffith$elm_ui$Internal$Model$Empty;
		}
	});
var $elm$virtual_dom$VirtualDom$mapAttribute = _VirtualDom_mapAttribute;
var $mdgriffith$elm_ui$Internal$Model$mapAttrFromStyle = F2(
	function (fn, attr) {
		switch (attr.$) {
			case 'NoAttribute':
				return $mdgriffith$elm_ui$Internal$Model$NoAttribute;
			case 'Describe':
				var description = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$Describe(description);
			case 'AlignX':
				var x = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$AlignX(x);
			case 'AlignY':
				var y = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$AlignY(y);
			case 'Width':
				var x = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$Width(x);
			case 'Height':
				var x = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$Height(x);
			case 'Class':
				var x = attr.a;
				var y = attr.b;
				return A2($mdgriffith$elm_ui$Internal$Model$Class, x, y);
			case 'StyleClass':
				var flag = attr.a;
				var style = attr.b;
				return A2($mdgriffith$elm_ui$Internal$Model$StyleClass, flag, style);
			case 'Nearby':
				var location = attr.a;
				var elem = attr.b;
				return A2(
					$mdgriffith$elm_ui$Internal$Model$Nearby,
					location,
					A2($mdgriffith$elm_ui$Internal$Model$map, fn, elem));
			case 'Attr':
				var htmlAttr = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$Attr(
					A2($elm$virtual_dom$VirtualDom$mapAttribute, fn, htmlAttr));
			default:
				var fl = attr.a;
				var trans = attr.b;
				return A2($mdgriffith$elm_ui$Internal$Model$TransformComponent, fl, trans);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$removeNever = function (style) {
	return A2($mdgriffith$elm_ui$Internal$Model$mapAttrFromStyle, $elm$core$Basics$never, style);
};
var $mdgriffith$elm_ui$Internal$Model$unwrapDecsHelper = F2(
	function (attr, _v0) {
		var styles = _v0.a;
		var trans = _v0.b;
		var _v1 = $mdgriffith$elm_ui$Internal$Model$removeNever(attr);
		switch (_v1.$) {
			case 'StyleClass':
				var style = _v1.b;
				return _Utils_Tuple2(
					A2($elm$core$List$cons, style, styles),
					trans);
			case 'TransformComponent':
				var flag = _v1.a;
				var component = _v1.b;
				return _Utils_Tuple2(
					styles,
					A2($mdgriffith$elm_ui$Internal$Model$composeTransformation, trans, component));
			default:
				return _Utils_Tuple2(styles, trans);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$unwrapDecorations = function (attrs) {
	var _v0 = A3(
		$elm$core$List$foldl,
		$mdgriffith$elm_ui$Internal$Model$unwrapDecsHelper,
		_Utils_Tuple2(_List_Nil, $mdgriffith$elm_ui$Internal$Model$Untransformed),
		attrs);
	var styles = _v0.a;
	var transform = _v0.b;
	return A2(
		$elm$core$List$cons,
		$mdgriffith$elm_ui$Internal$Model$Transform(transform),
		styles);
};
var $mdgriffith$elm_ui$Element$mouseOver = function (decs) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$hover,
		A2(
			$mdgriffith$elm_ui$Internal$Model$PseudoSelector,
			$mdgriffith$elm_ui$Internal$Model$Hover,
			$mdgriffith$elm_ui$Internal$Model$unwrapDecorations(decs)));
};
var $mdgriffith$elm_ui$Internal$Model$AsRow = {$: 'AsRow'};
var $mdgriffith$elm_ui$Internal$Model$asRow = $mdgriffith$elm_ui$Internal$Model$AsRow;
var $mdgriffith$elm_ui$Element$row = F2(
	function (attrs, children) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asRow,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentLeft + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.contentCenterY)),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
						attrs))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
	});
var $author$project$Colors$white = A3($mdgriffith$elm_ui$Element$rgb255, 255, 255, 255);
var $author$project$Pages$Browser$Source_String$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						A4(
						$author$project$Components$VerticalNav$view,
						'sources',
						model.route,
						A2(
							$elm$core$List$map,
							function (source) {
								return {
									label: source.label,
									route: $author$project$Spa$Generated$Route$Browser__Source_String(
										{
											source: $elm$url$Url$percentEncode(source.file)
										})
								};
							},
							model.source_list),
						_List_Nil),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
							]),
						A2(
							$elm$core$List$map,
							function (file) {
								var _v0 = file.filetype;
								if (_v0.$ === 'Directory') {
									return A2(
										$mdgriffith$elm_ui$Element$link,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Element$paddingXY, 10, 10),
												$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleDustGray),
												$mdgriffith$elm_ui$Element$mouseOver(
												_List_fromArray(
													[
														$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleOuterSpace)
													])),
												$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$white)
											]),
										{
											label: $mdgriffith$elm_ui$Element$text(file.label),
											url: $author$project$Spa$Generated$Route$toString(
												$author$project$Spa$Generated$Route$Browser__Source_String(
													{
														source: $elm$url$Url$percentEncode(file.file)
													}))
										});
								} else {
									return A2(
										$mdgriffith$elm_ui$Element$el,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Element$paddingXY, 10, 10),
												$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleDustGray),
												$mdgriffith$elm_ui$Element$mouseOver(
												_List_fromArray(
													[
														$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleOuterSpace)
													])),
												$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$white)
											]),
										$mdgriffith$elm_ui$Element$text(file.label));
								}
							},
							model.files))
					]))
			]),
		title: 'Browser.Source_String'
	};
};
var $author$project$Pages$Browser$Source_String$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Browser$Source_String$init, load: $author$project$Pages$Browser$Source_String$load, save: $author$project$Pages$Browser$Source_String$save, subscriptions: $author$project$Pages$Browser$Source_String$subscriptions, update: $author$project$Pages$Browser$Source_String$update, view: $author$project$Pages$Browser$Source_String$view});
var $author$project$Spa$Page$ignoreEffect = function (model) {
	return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
};
var $author$project$Spa$Page$static = function (page) {
	return {
		init: F2(
			function (_v0, url) {
				return _Utils_Tuple2(url, $elm$core$Platform$Cmd$none);
			}),
		load: $elm$core$Basics$always(
			A2($elm$core$Basics$composeR, $elm$core$Basics$identity, $author$project$Spa$Page$ignoreEffect)),
		save: $elm$core$Basics$always($elm$core$Basics$identity),
		subscriptions: function (_v1) {
			return $elm$core$Platform$Sub$none;
		},
		update: F2(
			function (_v2, model) {
				return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
			}),
		view: page.view
	};
};
var $author$project$Pages$Help$view = function (_v0) {
	var params = _v0.params;
	return {body: _List_Nil, title: 'Help'};
};
var $author$project$Pages$Help$page = $author$project$Spa$Page$static(
	{view: $author$project$Pages$Help$view});
var $author$project$Pages$Lab$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Lab$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Lab$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Lab$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Lab$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Lab$view = function (model) {
	return {body: _List_Nil, title: 'Lab'};
};
var $author$project$Pages$Lab$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Lab$init, load: $author$project$Pages$Lab$load, save: $author$project$Pages$Lab$save, subscriptions: $author$project$Pages$Lab$subscriptions, update: $author$project$Pages$Lab$update, view: $author$project$Pages$Lab$view});
var $author$project$Pages$Movies$init = F2(
	function (shared, url) {
		return _Utils_Tuple2(
			{currentlyPlaying: shared.currentlyPlaying, movie_list: shared.movie_list, route: url.route},
			$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "VideoLibrary.GetMovies", "params": { "filter": {"field": "playcount", "operator": "is", "value": "0"}, "properties" : ["art", "rating", "thumbnail", "playcount", "file"], "sort": { "order": "ascending", "method": "label", "ignorearticle": true } }, "id": "libMovies"}'));
	});
var $author$project$Pages$Movies$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{movie_list: shared.movie_list}),
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Movies$save = F2(
	function (model, shared) {
		return _Utils_update(
			shared,
			{currentlyPlaying: model.currentlyPlaying, movie_list: model.movie_list});
	});
var $author$project$Pages$Movies$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Movies$update = F2(
	function (msg, model) {
		var movie = msg.a;
		return _Utils_Tuple2(
			model,
			$author$project$Shared$sendActions(
				_List_fromArray(
					[
						'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
						'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"movieid": ' + ($elm$core$String$fromInt(movie.movieid) + '}}}'),
						'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
					])));
	});
var $icidasset$elm_material_icons$Material$Icons$Types$Color = function (a) {
	return {$: 'Color', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$Bottom = {$: 'Bottom'};
var $mdgriffith$elm_ui$Element$alignBottom = $mdgriffith$elm_ui$Internal$Model$AlignY($mdgriffith$elm_ui$Internal$Model$Bottom);
var $mdgriffith$elm_ui$Internal$Flag$overflow = $mdgriffith$elm_ui$Internal$Flag$flag(20);
var $mdgriffith$elm_ui$Element$clip = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$overflow, $mdgriffith$elm_ui$Internal$Style$classes.clip);
var $elm$url$Url$Builder$toQueryPair = function (_v0) {
	var key = _v0.a;
	var value = _v0.b;
	return key + ('=' + value);
};
var $elm$url$Url$Builder$toQuery = function (parameters) {
	if (!parameters.b) {
		return '';
	} else {
		return '?' + A2(
			$elm$core$String$join,
			'&',
			A2($elm$core$List$map, $elm$url$Url$Builder$toQueryPair, parameters));
	}
};
var $elm$url$Url$Builder$crossOrigin = F3(
	function (prePath, pathSegments, parameters) {
		return prePath + ('/' + (A2($elm$core$String$join, '/', pathSegments) + $elm$url$Url$Builder$toQuery(parameters)));
	});
var $avh4$elm_color$Color$RgbaSpace = F4(
	function (a, b, c, d) {
		return {$: 'RgbaSpace', a: a, b: b, c: c, d: d};
	});
var $avh4$elm_color$Color$rgba = F4(
	function (r, g, b, a) {
		return A4($avh4$elm_color$Color$RgbaSpace, r, g, b, a);
	});
var $author$project$Colors$greyIcon = A4($avh4$elm_color$Color$rgba, 1, 1, 1, 0.5);
var $mdgriffith$elm_ui$Internal$Model$unstyled = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Unstyled, $elm$core$Basics$always);
var $mdgriffith$elm_ui$Element$html = $mdgriffith$elm_ui$Internal$Model$unstyled;
var $elm$html$Html$Attributes$alt = $elm$html$Html$Attributes$stringProperty('alt');
var $elm$html$Html$Attributes$src = function (url) {
	return A2(
		$elm$html$Html$Attributes$stringProperty,
		'src',
		_VirtualDom_noJavaScriptOrHtmlUri(url));
};
var $mdgriffith$elm_ui$Element$image = F2(
	function (attrs, _v0) {
		var src = _v0.src;
		var description = _v0.description;
		var imageAttributes = A2(
			$elm$core$List$filter,
			function (a) {
				switch (a.$) {
					case 'Width':
						return true;
					case 'Height':
						return true;
					default:
						return false;
				}
			},
			attrs);
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.imageContainer),
				attrs),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(
				_List_fromArray(
					[
						A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asEl,
						$mdgriffith$elm_ui$Internal$Model$NodeName('img'),
						_Utils_ap(
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Internal$Model$Attr(
									$elm$html$Html$Attributes$src(src)),
									$mdgriffith$elm_ui$Internal$Model$Attr(
									$elm$html$Html$Attributes$alt(description))
								]),
							imageAttributes),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(_List_Nil))
					])));
	});
var $mdgriffith$elm_ui$Internal$Model$InFront = {$: 'InFront'};
var $mdgriffith$elm_ui$Element$createNearby = F2(
	function (loc, element) {
		if (element.$ === 'Empty') {
			return $mdgriffith$elm_ui$Internal$Model$NoAttribute;
		} else {
			return A2($mdgriffith$elm_ui$Internal$Model$Nearby, loc, element);
		}
	});
var $mdgriffith$elm_ui$Element$inFront = function (element) {
	return A2($mdgriffith$elm_ui$Element$createNearby, $mdgriffith$elm_ui$Internal$Model$InFront, element);
};
var $mdgriffith$elm_ui$Internal$Model$Max = F2(
	function (a, b) {
		return {$: 'Max', a: a, b: b};
	});
var $mdgriffith$elm_ui$Element$maximum = F2(
	function (i, l) {
		return A2($mdgriffith$elm_ui$Internal$Model$Max, i, l);
	});
var $mdgriffith$elm_ui$Internal$Model$Min = F2(
	function (a, b) {
		return {$: 'Min', a: a, b: b};
	});
var $mdgriffith$elm_ui$Element$minimum = F2(
	function (i, l) {
		return A2($mdgriffith$elm_ui$Internal$Model$Min, i, l);
	});
var $elm$svg$Svg$Attributes$d = _VirtualDom_attribute('d');
var $elm$svg$Svg$Attributes$fill = _VirtualDom_attribute('fill');
var $elm$svg$Svg$trustedNode = _VirtualDom_nodeNS('http://www.w3.org/2000/svg');
var $elm$svg$Svg$g = $elm$svg$Svg$trustedNode('g');
var $elm$svg$Svg$Attributes$height = _VirtualDom_attribute('height');
var $elm$svg$Svg$svg = $elm$svg$Svg$trustedNode('svg');
var $avh4$elm_color$Color$toCssString = function (_v0) {
	var r = _v0.a;
	var g = _v0.b;
	var b = _v0.c;
	var a = _v0.d;
	var roundTo = function (x) {
		return $elm$core$Basics$round(x * 1000) / 1000;
	};
	var pct = function (x) {
		return $elm$core$Basics$round(x * 10000) / 100;
	};
	return $elm$core$String$concat(
		_List_fromArray(
			[
				'rgba(',
				$elm$core$String$fromFloat(
				pct(r)),
				'%,',
				$elm$core$String$fromFloat(
				pct(g)),
				'%,',
				$elm$core$String$fromFloat(
				pct(b)),
				'%,',
				$elm$core$String$fromFloat(
				roundTo(a)),
				')'
			]));
};
var $elm$svg$Svg$Attributes$width = _VirtualDom_attribute('width');
var $icidasset$elm_material_icons$Material$Icons$Internal$icon = F4(
	function (attributes, nodes, size, coloring) {
		var sizeAsString = $elm$core$String$fromInt(size);
		return A2(
			$elm$svg$Svg$svg,
			_Utils_ap(
				attributes,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$height(sizeAsString),
						$elm$svg$Svg$Attributes$width(sizeAsString)
					])),
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$g,
					_List_fromArray(
						[
							function () {
							if (coloring.$ === 'Color') {
								var color = coloring.a;
								return $elm$svg$Svg$Attributes$fill(
									$avh4$elm_color$Color$toCssString(color));
							} else {
								return $elm$svg$Svg$Attributes$fill('currentColor');
							}
						}()
						]),
					nodes)
				]));
	});
var $elm$svg$Svg$path = $elm$svg$Svg$trustedNode('path');
var $elm$svg$Svg$Attributes$viewBox = _VirtualDom_attribute('viewBox');
var $icidasset$elm_material_icons$Material$Icons$play_arrow = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M8 5v14l11-7z')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil)
		]));
var $mdgriffith$elm_ui$Element$rgb = F3(
	function (r, g, b) {
		return A4($mdgriffith$elm_ui$Internal$Model$Rgba, r, g, b, 1);
	});
var $mdgriffith$elm_ui$Internal$Model$FontSize = function (a) {
	return {$: 'FontSize', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$fontSize = $mdgriffith$elm_ui$Internal$Flag$flag(4);
var $mdgriffith$elm_ui$Element$Font$size = function (i) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$fontSize,
		$mdgriffith$elm_ui$Internal$Model$FontSize(i));
};
var $mdgriffith$elm_ui$Element$spacingXY = F2(
	function (x, y) {
		return A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$spacing,
			A3(
				$mdgriffith$elm_ui$Internal$Model$SpacingStyle,
				A2($mdgriffith$elm_ui$Internal$Model$spacingName, x, y),
				x,
				y));
	});
var $author$project$Pages$Movies$constructMovieItem = function (movie) {
	return A2(
		$mdgriffith$elm_ui$Element$column,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$spacingXY, 5, 0),
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$image,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							150,
							A2($mdgriffith$elm_ui$Element$minimum, 150, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$height(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							200,
							A2($mdgriffith$elm_ui$Element$minimum, 200, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$inFront(
						A2(
							$mdgriffith$elm_ui$Element$row,
							_List_Nil,
							_List_fromArray(
								[
									A2(
									$mdgriffith$elm_ui$Element$link,
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Element$paddingXY, 5, 3),
											$mdgriffith$elm_ui$Element$Background$color(
											A3($mdgriffith$elm_ui$Element$rgb, 0.2, 0.2, 0.2))
										]),
									{
										label: $mdgriffith$elm_ui$Element$html(
											A2(
												$icidasset$elm_material_icons$Material$Icons$play_arrow,
												24,
												$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
										url: $author$project$Spa$Generated$Route$toString(
											$author$project$Spa$Generated$Route$Videoplayer__Movieid_Int(
												{movieid: movie.movieid}))
									})
								])))
					]),
				$elm$core$String$isEmpty(movie.thumbnail) ? {description: 'Hero Image', src: 'https://via.placeholder.com/70'} : {
					description: movie.label,
					src: A3(
						$elm$url$Url$Builder$crossOrigin,
						'http://localhost:8080',
						_List_fromArray(
							[
								'image',
								$elm$url$Url$percentEncode(movie.thumbnail)
							]),
						_List_Nil)
				}),
				A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alignBottom,
						$mdgriffith$elm_ui$Element$Background$color(
						A3($mdgriffith$elm_ui$Element$rgb, 1, 1, 1)),
						$mdgriffith$elm_ui$Element$width(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							150,
							A2($mdgriffith$elm_ui$Element$minimum, 150, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$clip
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0, 0, 0)),
								$mdgriffith$elm_ui$Element$Font$size(18)
							]),
						$mdgriffith$elm_ui$Element$text(movie.label)),
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
								$mdgriffith$elm_ui$Element$Font$size(18)
							]),
						$mdgriffith$elm_ui$Element$text('2020'))
					]))
			]));
};
var $author$project$Components$VerticalNavMovies$view = function (currentRoute) {
	return A4(
		$author$project$Components$VerticalNav$view,
		'sections',
		currentRoute,
		_List_fromArray(
			[
				{label: 'Movies', route: $author$project$Spa$Generated$Route$Movies__Recent},
				{label: 'All movies', route: $author$project$Spa$Generated$Route$Movies}
			]),
		_List_fromArray(
			[$author$project$Spa$Generated$Route$Movies]));
};
var $mdgriffith$elm_ui$Internal$Model$Padding = F5(
	function (a, b, c, d, e) {
		return {$: 'Padding', a: a, b: b, c: c, d: d, e: e};
	});
var $mdgriffith$elm_ui$Internal$Model$Spaced = F3(
	function (a, b, c) {
		return {$: 'Spaced', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Internal$Model$extractSpacingAndPadding = function (attrs) {
	return A3(
		$elm$core$List$foldr,
		F2(
			function (attr, _v0) {
				var pad = _v0.a;
				var spacing = _v0.b;
				return _Utils_Tuple2(
					function () {
						if (pad.$ === 'Just') {
							var x = pad.a;
							return pad;
						} else {
							if ((attr.$ === 'StyleClass') && (attr.b.$ === 'PaddingStyle')) {
								var _v3 = attr.b;
								var name = _v3.a;
								var t = _v3.b;
								var r = _v3.c;
								var b = _v3.d;
								var l = _v3.e;
								return $elm$core$Maybe$Just(
									A5($mdgriffith$elm_ui$Internal$Model$Padding, name, t, r, b, l));
							} else {
								return $elm$core$Maybe$Nothing;
							}
						}
					}(),
					function () {
						if (spacing.$ === 'Just') {
							var x = spacing.a;
							return spacing;
						} else {
							if ((attr.$ === 'StyleClass') && (attr.b.$ === 'SpacingStyle')) {
								var _v6 = attr.b;
								var name = _v6.a;
								var x = _v6.b;
								var y = _v6.c;
								return $elm$core$Maybe$Just(
									A3($mdgriffith$elm_ui$Internal$Model$Spaced, name, x, y));
							} else {
								return $elm$core$Maybe$Nothing;
							}
						}
					}());
			}),
		_Utils_Tuple2($elm$core$Maybe$Nothing, $elm$core$Maybe$Nothing),
		attrs);
};
var $mdgriffith$elm_ui$Internal$Model$paddingNameFloat = F4(
	function (top, right, bottom, left) {
		return 'pad-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(top) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(right) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(bottom) + ('-' + $mdgriffith$elm_ui$Internal$Model$floatClass(left)))))));
	});
var $mdgriffith$elm_ui$Element$wrappedRow = F2(
	function (attrs, children) {
		var _v0 = $mdgriffith$elm_ui$Internal$Model$extractSpacingAndPadding(attrs);
		var padded = _v0.a;
		var spaced = _v0.b;
		if (spaced.$ === 'Nothing') {
			return A4(
				$mdgriffith$elm_ui$Internal$Model$element,
				$mdgriffith$elm_ui$Internal$Model$asRow,
				$mdgriffith$elm_ui$Internal$Model$div,
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentLeft + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.wrapped)))),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
							attrs))),
				$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
		} else {
			var _v2 = spaced.a;
			var spaceName = _v2.a;
			var x = _v2.b;
			var y = _v2.c;
			var newPadding = function () {
				if (padded.$ === 'Just') {
					var _v5 = padded.a;
					var name = _v5.a;
					var t = _v5.b;
					var r = _v5.c;
					var b = _v5.d;
					var l = _v5.e;
					if ((_Utils_cmp(r, x / 2) > -1) && (_Utils_cmp(b, y / 2) > -1)) {
						var newTop = t - (y / 2);
						var newRight = r - (x / 2);
						var newLeft = l - (x / 2);
						var newBottom = b - (y / 2);
						return $elm$core$Maybe$Just(
							A2(
								$mdgriffith$elm_ui$Internal$Model$StyleClass,
								$mdgriffith$elm_ui$Internal$Flag$padding,
								A5(
									$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
									A4($mdgriffith$elm_ui$Internal$Model$paddingNameFloat, newTop, newRight, newBottom, newLeft),
									newTop,
									newRight,
									newBottom,
									newLeft)));
					} else {
						return $elm$core$Maybe$Nothing;
					}
				} else {
					return $elm$core$Maybe$Nothing;
				}
			}();
			if (newPadding.$ === 'Just') {
				var pad = newPadding.a;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$element,
					$mdgriffith$elm_ui$Internal$Model$asRow,
					$mdgriffith$elm_ui$Internal$Model$div,
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentLeft + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.wrapped)))),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
							A2(
								$elm$core$List$cons,
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
								_Utils_ap(
									attrs,
									_List_fromArray(
										[pad]))))),
					$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
			} else {
				var halfY = -(y / 2);
				var halfX = -(x / 2);
				return A4(
					$mdgriffith$elm_ui$Internal$Model$element,
					$mdgriffith$elm_ui$Internal$Model$asEl,
					$mdgriffith$elm_ui$Internal$Model$div,
					attrs,
					$mdgriffith$elm_ui$Internal$Model$Unkeyed(
						_List_fromArray(
							[
								A4(
								$mdgriffith$elm_ui$Internal$Model$element,
								$mdgriffith$elm_ui$Internal$Model$asRow,
								$mdgriffith$elm_ui$Internal$Model$div,
								A2(
									$elm$core$List$cons,
									$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentLeft + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.wrapped)))),
									A2(
										$elm$core$List$cons,
										$mdgriffith$elm_ui$Internal$Model$Attr(
											A2(
												$elm$html$Html$Attributes$style,
												'margin',
												$elm$core$String$fromFloat(halfY) + ('px' + (' ' + ($elm$core$String$fromFloat(halfX) + 'px'))))),
										A2(
											$elm$core$List$cons,
											$mdgriffith$elm_ui$Internal$Model$Attr(
												A2(
													$elm$html$Html$Attributes$style,
													'width',
													'calc(100% + ' + ($elm$core$String$fromInt(x) + 'px)'))),
											A2(
												$elm$core$List$cons,
												$mdgriffith$elm_ui$Internal$Model$Attr(
													A2(
														$elm$html$Html$Attributes$style,
														'height',
														'calc(100% + ' + ($elm$core$String$fromInt(y) + 'px)'))),
												A2(
													$elm$core$List$cons,
													A2(
														$mdgriffith$elm_ui$Internal$Model$StyleClass,
														$mdgriffith$elm_ui$Internal$Flag$spacing,
														A3($mdgriffith$elm_ui$Internal$Model$SpacingStyle, spaceName, x, y)),
													_List_Nil))))),
								$mdgriffith$elm_ui$Internal$Model$Unkeyed(children))
							])));
			}
		}
	});
var $author$project$Pages$Movies$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavMovies$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$wrappedRow,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								$mdgriffith$elm_ui$Element$Background$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0.8, 0.8, 0.8)),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 10)
							]),
						A2(
							$elm$core$List$map,
							function (movie) {
								return $author$project$Pages$Movies$constructMovieItem(movie);
							},
							model.movie_list))
					]))
			]),
		title: 'Movies'
	};
};
var $author$project$Pages$Movies$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Movies$init, load: $author$project$Pages$Movies$load, save: $author$project$Pages$Movies$save, subscriptions: $author$project$Pages$Movies$subscriptions, update: $author$project$Pages$Movies$update, view: $author$project$Pages$Movies$view});
var $author$project$Pages$Movies$Recent$init = F2(
	function (shared, url) {
		return _Utils_Tuple2(
			{currentlyPlaying: shared.currentlyPlaying, movie_list: shared.movie_list, route: url.route},
			$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "VideoLibrary.GetMovies", "params": { "filter": {"field": "playcount", "operator": "is", "value": "0"}, "properties" : ["art", "rating", "thumbnail", "playcount", "file"], "sort": { "order": "ascending", "method": "label", "ignorearticle": true } }, "id": "libMovies"}'));
	});
var $author$project$Pages$Movies$Recent$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{movie_list: shared.movie_list}),
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Movies$Recent$save = F2(
	function (model, shared) {
		return _Utils_update(
			shared,
			{currentlyPlaying: model.currentlyPlaying, movie_list: model.movie_list});
	});
var $author$project$Pages$Movies$Recent$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Movies$Recent$update = F2(
	function (msg, model) {
		if (msg.$ === 'SetCurrentlyPlaying') {
			var movie = msg.a;
			return _Utils_Tuple2(
				model,
				$author$project$Shared$sendActions(
					_List_fromArray(
						[
							'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
							'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"movieid": ' + ($elm$core$String$fromInt(movie.movieid) + '}}}'),
							'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
						])));
		} else {
			return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
		}
	});
var $author$project$Colors$background = A3($mdgriffith$elm_ui$Element$rgb255, 224, 223, 223);
var $author$project$Pages$Movies$Recent$NoOp = {$: 'NoOp'};
var $mdgriffith$elm_ui$Internal$Model$Button = {$: 'Button'};
var $elm$json$Json$Encode$bool = _Json_wrap;
var $elm$html$Html$Attributes$boolProperty = F2(
	function (key, bool) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$bool(bool));
	});
var $elm$html$Html$Attributes$disabled = $elm$html$Html$Attributes$boolProperty('disabled');
var $mdgriffith$elm_ui$Element$Input$enter = 'Enter';
var $mdgriffith$elm_ui$Element$Input$hasFocusStyle = function (attr) {
	if (((attr.$ === 'StyleClass') && (attr.b.$ === 'PseudoSelector')) && (attr.b.a.$ === 'Focus')) {
		var _v1 = attr.b;
		var _v2 = _v1.a;
		return true;
	} else {
		return false;
	}
};
var $mdgriffith$elm_ui$Element$Input$focusDefault = function (attrs) {
	return A2($elm$core$List$any, $mdgriffith$elm_ui$Element$Input$hasFocusStyle, attrs) ? $mdgriffith$elm_ui$Internal$Model$NoAttribute : $mdgriffith$elm_ui$Internal$Model$htmlClass('focusable');
};
var $mdgriffith$elm_ui$Element$Events$onClick = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Events$onClick);
var $elm$json$Json$Decode$fail = _Json_fail;
var $elm$virtual_dom$VirtualDom$MayPreventDefault = function (a) {
	return {$: 'MayPreventDefault', a: a};
};
var $elm$html$Html$Events$preventDefaultOn = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$MayPreventDefault(decoder));
	});
var $mdgriffith$elm_ui$Element$Input$onKeyLookup = function (lookup) {
	var decode = function (code) {
		var _v0 = lookup(code);
		if (_v0.$ === 'Nothing') {
			return $elm$json$Json$Decode$fail('No key matched');
		} else {
			var msg = _v0.a;
			return $elm$json$Json$Decode$succeed(msg);
		}
	};
	var isKey = A2(
		$elm$json$Json$Decode$andThen,
		decode,
		A2($elm$json$Json$Decode$field, 'key', $elm$json$Json$Decode$string));
	return $mdgriffith$elm_ui$Internal$Model$Attr(
		A2(
			$elm$html$Html$Events$preventDefaultOn,
			'keydown',
			A2(
				$elm$json$Json$Decode$map,
				function (fired) {
					return _Utils_Tuple2(fired, true);
				},
				isKey)));
};
var $mdgriffith$elm_ui$Internal$Flag$cursor = $mdgriffith$elm_ui$Internal$Flag$flag(21);
var $mdgriffith$elm_ui$Element$pointer = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$cursor, $mdgriffith$elm_ui$Internal$Style$classes.cursorPointer);
var $mdgriffith$elm_ui$Element$Input$space = ' ';
var $elm$html$Html$Attributes$tabindex = function (n) {
	return A2(
		_VirtualDom_attribute,
		'tabIndex',
		$elm$core$String$fromInt(n));
};
var $mdgriffith$elm_ui$Element$Input$button = F2(
	function (attrs, _v0) {
		var onPress = _v0.onPress;
		var label = _v0.label;
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentCenterX + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.seButton + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.noTextSelection)))))),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Element$pointer,
							A2(
								$elm$core$List$cons,
								$mdgriffith$elm_ui$Element$Input$focusDefault(attrs),
								A2(
									$elm$core$List$cons,
									$mdgriffith$elm_ui$Internal$Model$Describe($mdgriffith$elm_ui$Internal$Model$Button),
									A2(
										$elm$core$List$cons,
										$mdgriffith$elm_ui$Internal$Model$Attr(
											$elm$html$Html$Attributes$tabindex(0)),
										function () {
											if (onPress.$ === 'Nothing') {
												return A2(
													$elm$core$List$cons,
													$mdgriffith$elm_ui$Internal$Model$Attr(
														$elm$html$Html$Attributes$disabled(true)),
													attrs);
											} else {
												var msg = onPress.a;
												return A2(
													$elm$core$List$cons,
													$mdgriffith$elm_ui$Element$Events$onClick(msg),
													A2(
														$elm$core$List$cons,
														$mdgriffith$elm_ui$Element$Input$onKeyLookup(
															function (code) {
																return _Utils_eq(code, $mdgriffith$elm_ui$Element$Input$enter) ? $elm$core$Maybe$Just(msg) : (_Utils_eq(code, $mdgriffith$elm_ui$Element$Input$space) ? $elm$core$Maybe$Just(msg) : $elm$core$Maybe$Nothing);
															}),
														attrs));
											}
										}()))))))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(
				_List_fromArray(
					[label])));
	});
var $author$project$Pages$Movies$Recent$materialButton = function (_v0) {
	var icon = _v0.a;
	var action = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 3),
				$mdgriffith$elm_ui$Element$Background$color(
				A3($mdgriffith$elm_ui$Element$rgb, 0.2, 0.2, 0.2))
			]),
		{
			label: $mdgriffith$elm_ui$Element$html(
				A2(
					icon,
					24,
					$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
			onPress: $elm$core$Maybe$Just(action)
		});
};
var $author$project$Pages$Movies$Recent$constructMovieItem = function (movie) {
	return A2(
		$mdgriffith$elm_ui$Element$column,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$spacingXY, 5, 0),
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$image,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							150,
							A2($mdgriffith$elm_ui$Element$minimum, 150, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$height(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							200,
							A2($mdgriffith$elm_ui$Element$minimum, 200, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$inFront(
						A2(
							$mdgriffith$elm_ui$Element$row,
							_List_Nil,
							_List_fromArray(
								[
									$author$project$Pages$Movies$Recent$materialButton(
									_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$play_arrow, $author$project$Pages$Movies$Recent$NoOp))
								])))
					]),
				$elm$core$String$isEmpty(movie.thumbnail) ? {description: 'Hero Image', src: 'https://via.placeholder.com/70'} : {
					description: movie.label,
					src: A3(
						$elm$url$Url$Builder$crossOrigin,
						'http://localhost:8080',
						_List_fromArray(
							[
								'image',
								$elm$url$Url$percentEncode(movie.thumbnail)
							]),
						_List_Nil)
				}),
				A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alignBottom,
						$mdgriffith$elm_ui$Element$Background$color(
						A3($mdgriffith$elm_ui$Element$rgb, 1, 1, 1)),
						$mdgriffith$elm_ui$Element$width(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							150,
							A2($mdgriffith$elm_ui$Element$minimum, 150, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$clip
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0, 0, 0)),
								$mdgriffith$elm_ui$Element$Font$size(18)
							]),
						$mdgriffith$elm_ui$Element$text(movie.label)),
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
								$mdgriffith$elm_ui$Element$Font$size(18)
							]),
						$mdgriffith$elm_ui$Element$text('2020'))
					]))
			]));
};
var $mdgriffith$elm_ui$Internal$Model$Right = {$: 'Right'};
var $mdgriffith$elm_ui$Element$alignRight = $mdgriffith$elm_ui$Internal$Model$AlignX($mdgriffith$elm_ui$Internal$Model$Right);
var $avh4$elm_color$Color$fromRgba = function (components) {
	return A4($avh4$elm_color$Color$RgbaSpace, components.red, components.green, components.blue, components.alpha);
};
var $mdgriffith$elm_ui$Element$toRgb = function (_v0) {
	var r = _v0.a;
	var g = _v0.b;
	var b = _v0.c;
	var a = _v0.d;
	return {alpha: a, blue: b, green: g, red: r};
};
var $author$project$Colors$fromElementColorToColor = function (color) {
	return $avh4$elm_color$Color$fromRgba(
		$mdgriffith$elm_ui$Element$toRgb(color));
};
var $author$project$Colors$grey = A3($mdgriffith$elm_ui$Element$rgb255, 51, 51, 51);
var $mdgriffith$elm_ui$Internal$Model$Below = {$: 'Below'};
var $mdgriffith$elm_ui$Element$below = function (element) {
	return A2($mdgriffith$elm_ui$Element$createNearby, $mdgriffith$elm_ui$Internal$Model$Below, element);
};
var $mdgriffith$elm_ui$Internal$Model$CenterX = {$: 'CenterX'};
var $mdgriffith$elm_ui$Element$centerX = $mdgriffith$elm_ui$Internal$Model$AlignX($mdgriffith$elm_ui$Internal$Model$CenterX);
var $mdgriffith$elm_ui$Internal$Model$Px = function (a) {
	return {$: 'Px', a: a};
};
var $mdgriffith$elm_ui$Element$px = $mdgriffith$elm_ui$Internal$Model$Px;
var $author$project$Components$SectionHeader$moreVertMenu = F2(
	function (showMenu, moreVertItems) {
		return showMenu ? _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$below(
				A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$px(250)),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$grey)
						]),
					A2(
						$elm$core$List$map,
						function (n) {
							return A2(
								$mdgriffith$elm_ui$Element$Input$button,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height(
										$mdgriffith$elm_ui$Element$px(50)),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$centerX,
										$mdgriffith$elm_ui$Element$alignRight
									]),
								{
									label: $mdgriffith$elm_ui$Element$text(n.title),
									onPress: n.action
								});
						},
						moreVertItems)))
			]) : _List_Nil;
	});
var $icidasset$elm_material_icons$Material$Icons$more_vert = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 6c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z')
				]),
			_List_Nil)
		]));
var $mdgriffith$elm_ui$Internal$Model$paddingName = F4(
	function (top, right, bottom, left) {
		return 'pad-' + ($elm$core$String$fromInt(top) + ('-' + ($elm$core$String$fromInt(right) + ('-' + ($elm$core$String$fromInt(bottom) + ('-' + $elm$core$String$fromInt(left)))))));
	});
var $mdgriffith$elm_ui$Element$paddingEach = function (_v0) {
	var top = _v0.top;
	var right = _v0.right;
	var bottom = _v0.bottom;
	var left = _v0.left;
	if (_Utils_eq(top, right) && (_Utils_eq(top, bottom) && _Utils_eq(top, left))) {
		var topFloat = top;
		return A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$padding,
			A5(
				$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
				'p-' + $elm$core$String$fromInt(top),
				topFloat,
				topFloat,
				topFloat,
				topFloat));
	} else {
		return A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$padding,
			A5(
				$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
				A4($mdgriffith$elm_ui$Internal$Model$paddingName, top, right, bottom, left),
				top,
				right,
				bottom,
				left));
	}
};
var $author$project$Components$SectionHeader$view = F4(
	function (headline, toggleMoreVertAction, showMoreVertIcons, moreVertItems) {
		return A2(
			$mdgriffith$elm_ui$Element$row,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(50)),
					$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$white),
					$mdgriffith$elm_ui$Element$Font$size(18),
					$mdgriffith$elm_ui$Element$paddingEach(
					{bottom: 0, left: 16, right: 50, top: 0})
				]),
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$text(headline),
					A2(
					$mdgriffith$elm_ui$Element$Input$button,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height(
							$mdgriffith$elm_ui$Element$px(50)),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$px(50)),
							$mdgriffith$elm_ui$Element$alignRight
						]),
					{
						label: A2(
							$mdgriffith$elm_ui$Element$el,
							A2($author$project$Components$SectionHeader$moreVertMenu, showMoreVertIcons, moreVertItems),
							$mdgriffith$elm_ui$Element$html(
								A2(
									$icidasset$elm_material_icons$Material$Icons$more_vert,
									18,
									$icidasset$elm_material_icons$Material$Icons$Types$Color(
										$author$project$Colors$fromElementColorToColor($author$project$Colors$grey))))),
						onPress: toggleMoreVertAction
					})
				]));
	});
var $author$project$Pages$Movies$Recent$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavMovies$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
								$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
							]),
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, 'Recently Added Movies', $elm$core$Maybe$Nothing, false, _List_Nil),
										A2(
										$mdgriffith$elm_ui$Element$wrappedRow,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
												$mdgriffith$elm_ui$Element$width(
												$mdgriffith$elm_ui$Element$fillPortion(6)),
												$mdgriffith$elm_ui$Element$Background$color(
												A3($mdgriffith$elm_ui$Element$rgb, 0.8, 0.8, 0.8)),
												A2($mdgriffith$elm_ui$Element$spacingXY, 5, 10)
											]),
										A2(
											$elm$core$List$map,
											function (movie) {
												return $author$project$Pages$Movies$Recent$constructMovieItem(movie);
											},
											model.movie_list))
									])),
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, 'All Movies', $elm$core$Maybe$Nothing, false, _List_Nil),
										A2(
										$mdgriffith$elm_ui$Element$wrappedRow,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
												$mdgriffith$elm_ui$Element$width(
												$mdgriffith$elm_ui$Element$fillPortion(6)),
												$mdgriffith$elm_ui$Element$Background$color(
												A3($mdgriffith$elm_ui$Element$rgb, 0.8, 0.8, 0.8)),
												A2($mdgriffith$elm_ui$Element$spacingXY, 5, 10)
											]),
										A2(
											$elm$core$List$map,
											function (movie) {
												return $author$project$Pages$Movies$Recent$constructMovieItem(movie);
											},
											model.movie_list))
									]))
							]))
					]))
			]),
		title: 'Movies'
	};
};
var $author$project$Pages$Movies$Recent$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Movies$Recent$init, load: $author$project$Pages$Movies$Recent$load, save: $author$project$Pages$Movies$Recent$save, subscriptions: $author$project$Pages$Movies$Recent$subscriptions, update: $author$project$Pages$Movies$Recent$update, view: $author$project$Pages$Movies$Recent$view});
var $author$project$Pages$Music$init = F2(
	function (shared, url) {
		return _Utils_Tuple2(
			{album_list: shared.album_list, currentlyPlaying: shared.currentlyPlaying, route: url.route},
			$author$project$Shared$sendActions(
				_List_fromArray(
					['{"jsonrpc": "2.0", "method": "AudioLibrary.GetSongs", "params": { "properties": [ "artist", "duration", "album", "track", "genre", "albumid" ], "sort": { "order": "ascending", "method": "track", "ignorearticle": true } }, "id": "libSongs"}', '{"jsonrpc": "2.0", "method": "AudioLibrary.GetAlbums", "params": { "properties": ["playcount", "artist", "genre", "rating", "thumbnail", "year", "mood", "style", "dateadded"] }, "id": "libAlbums"}', '{"jsonrpc": "2.0", "method": "AudioLibrary.GetArtists", "params": { "properties": [ "thumbnail", "fanart", "born", "formed", "died", "disbanded", "yearsactive", "mood", "style", "genre" ], "sort": { "order": "ascending", "method": "artist", "ignorearticle": true } }, "id": 1}', '{"jsonrpc": "2.0", "method": "VideoLibrary.GetMusicVideos", "params": { "properties": [ "title", "thumbnail", "artist", "album", "genre", "lastplayed", "year", "runtime", "fanart", "file", "streamdetails" ] }, "id": "libMusicVideos"}'])));
	});
var $author$project$Pages$Music$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{album_list: shared.album_list}),
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Music$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Music$update = F2(
	function (msg, model) {
		var song = msg.a;
		return _Utils_Tuple2(
			model,
			$author$project$Shared$sendActions(
				_List_fromArray(
					[
						'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
						'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": ' + ($elm$core$String$fromInt(song.songid) + '}}}'),
						'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
					])));
	});
var $elm$core$List$sortBy = _List_sortBy;
var $author$project$Components$VerticalNavMusic$view = function (currentRoute) {
	return A4(
		$author$project$Components$VerticalNav$view,
		'sections',
		currentRoute,
		_List_fromArray(
			[
				{label: 'Music', route: $author$project$Spa$Generated$Route$Music},
				{label: 'Genres', route: $author$project$Spa$Generated$Route$Music__Genres},
				{label: 'Top Music', route: $author$project$Spa$Generated$Route$Music__Top__Top},
				{label: 'Artists', route: $author$project$Spa$Generated$Route$Music__Artists},
				{label: 'Albums', route: $author$project$Spa$Generated$Route$Music__Albums},
				{label: 'Videos', route: $author$project$Spa$Generated$Route$Music__Videos}
			]),
		_List_fromArray(
			[$author$project$Spa$Generated$Route$Music__Artists, $author$project$Spa$Generated$Route$Music__Albums, $author$project$Spa$Generated$Route$Music__Videos]));
};
var $mdgriffith$elm_ui$Internal$Model$Top = {$: 'Top'};
var $mdgriffith$elm_ui$Element$alignTop = $mdgriffith$elm_ui$Internal$Model$AlignY($mdgriffith$elm_ui$Internal$Model$Top);
var $author$project$Colors$black = A3($mdgriffith$elm_ui$Element$rgb255, 0, 0, 0);
var $mdgriffith$elm_ui$Internal$Flag$fontAlignment = $mdgriffith$elm_ui$Internal$Flag$flag(12);
var $mdgriffith$elm_ui$Element$Font$center = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$fontAlignment, $mdgriffith$elm_ui$Internal$Style$classes.textCenter);
var $mdgriffith$elm_ui$Element$clipX = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$overflow, $mdgriffith$elm_ui$Internal$Style$classes.clipX);
var $mdgriffith$elm_ui$Internal$Flag$borderRound = $mdgriffith$elm_ui$Internal$Flag$flag(17);
var $mdgriffith$elm_ui$Element$Border$rounded = function (radius) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$borderRound,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Single,
			'br-' + $elm$core$String$fromInt(radius),
			'border-radius',
			$elm$core$String$fromInt(radius) + 'px'));
};
var $author$project$Components$SectionHeader$viewAlbums = function (albumlist) {
	return A2(
		$mdgriffith$elm_ui$Element$wrappedRow,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
				A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7)
			]),
		A2(
			$elm$core$List$map,
			function (album) {
				return A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
							$mdgriffith$elm_ui$Element$Background$color(
							A3($mdgriffith$elm_ui$Element$rgb, 1, 1, 1)),
							$mdgriffith$elm_ui$Element$mouseOver(
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$sidebar)
								])),
							$mdgriffith$elm_ui$Element$height(
							A2($mdgriffith$elm_ui$Element$maximum, 220, $mdgriffith$elm_ui$Element$fill)),
							$mdgriffith$elm_ui$Element$width(
							A2(
								$mdgriffith$elm_ui$Element$maximum,
								160,
								A2($mdgriffith$elm_ui$Element$minimum, 160, $mdgriffith$elm_ui$Element$fill))),
							$mdgriffith$elm_ui$Element$Border$rounded(3),
							$mdgriffith$elm_ui$Element$clipX
						]),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Element$image,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$alignTop,
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
									$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
								]),
							{
								description: 'Thumbnail',
								src: A3(
									$elm$url$Url$Builder$crossOrigin,
									'http://localhost:8080',
									_List_fromArray(
										[
											'image',
											$elm$url$Url$percentEncode(album.thumbnail)
										]),
									_List_Nil)
							}),
							A2(
							$mdgriffith$elm_ui$Element$link,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$alignBottom,
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
									$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
									A2($mdgriffith$elm_ui$Element$paddingXY, 7, 16),
									$mdgriffith$elm_ui$Element$Font$center,
									$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$black)
								]),
							{
								label: A2(
									$mdgriffith$elm_ui$Element$column,
									_List_Nil,
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$text(album.label),
											A2(
											$mdgriffith$elm_ui$Element$wrappedRow,
											_List_Nil,
											A2(
												$elm$core$List$map,
												function (artist) {
													return $mdgriffith$elm_ui$Element$text(artist);
												},
												album.artist))
										])),
								url: $author$project$Spa$Generated$Route$toString(
									$author$project$Spa$Generated$Route$Music__Album__Albumid_Int(
										{albumid: album.albumid}))
							})
						]));
			},
			albumlist));
};
var $author$project$Pages$Music$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavMusic$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
								$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
							]),
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, 'Recently Added Albums', $elm$core$Maybe$Nothing, false, _List_Nil),
										$author$project$Components$SectionHeader$viewAlbums(
										$elm$core$List$reverse(
											A2(
												$elm$core$List$sortBy,
												function ($) {
													return $.albumid;
												},
												model.album_list)))
									])),
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, 'Recently Played Albums', $elm$core$Maybe$Nothing, false, _List_Nil),
										$author$project$Components$SectionHeader$viewAlbums(
										$elm$core$List$reverse(
											A2(
												$elm$core$List$sortBy,
												function ($) {
													return $.playcount;
												},
												model.album_list)))
									])),
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, 'All Albums', $elm$core$Maybe$Nothing, false, _List_Nil),
										$author$project$Components$SectionHeader$viewAlbums(model.album_list)
									]))
							]))
					]))
			]),
		title: 'Music'
	};
};
var $author$project$Pages$Music$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Music$init, load: $author$project$Pages$Music$load, save: $author$project$Pages$Music$save, subscriptions: $author$project$Pages$Music$subscriptions, update: $author$project$Pages$Music$update, view: $author$project$Pages$Music$view});
var $author$project$Pages$Music$Album$Albumid_Int$checkAlbumId = F2(
	function (firstId, album) {
		return _Utils_eq(firstId, album.albumid) ? true : false;
	});
var $elm$core$List$head = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(x);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Pages$Music$Album$Albumid_Int$getAlbum = F2(
	function (id, albumlist) {
		return $elm$core$List$head(
			A2(
				$elm$core$List$filter,
				function (album) {
					return A2($author$project$Pages$Music$Album$Albumid_Int$checkAlbumId, id, album);
				},
				albumlist));
	});
var $author$project$Pages$Music$Album$Albumid_Int$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{
				album: A2($author$project$Pages$Music$Album$Albumid_Int$getAlbum, params.albumid, shared.album_list),
				albumid: params.albumid,
				song_list: A2(
					$elm$core$List$filter,
					function (song) {
						return _Utils_eq(song.albumid, params.albumid);
					},
					shared.song_list)
			},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Album$Albumid_Int$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Album$Albumid_Int$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Music$Album$Albumid_Int$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Music$Album$Albumid_Int$update = F2(
	function (msg, model) {
		var song = msg.a;
		return _Utils_Tuple2(
			model,
			$author$project$Shared$sendActions(
				_List_fromArray(
					[
						'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
						'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": ' + ($elm$core$String$fromInt(song.songid) + '}}}'),
						'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
					])));
	});
var $author$project$Pages$Music$Album$Albumid_Int$SetCurrentlyPlaying = function (a) {
	return {$: 'SetCurrentlyPlaying', a: a};
};
var $elm$core$Basics$modBy = _Basics_modBy;
var $elm$core$String$cons = _String_cons;
var $elm$core$String$fromChar = function (_char) {
	return A2($elm$core$String$cons, _char, '');
};
var $elm$core$Bitwise$shiftRightBy = _Bitwise_shiftRightBy;
var $elm$core$String$repeatHelp = F3(
	function (n, chunk, result) {
		return (n <= 0) ? result : A3(
			$elm$core$String$repeatHelp,
			n >> 1,
			_Utils_ap(chunk, chunk),
			(!(n & 1)) ? result : _Utils_ap(result, chunk));
	});
var $elm$core$String$repeat = F2(
	function (n, chunk) {
		return A3($elm$core$String$repeatHelp, n, chunk, '');
	});
var $elm$core$String$padLeft = F3(
	function (n, _char, string) {
		return _Utils_ap(
			A2(
				$elm$core$String$repeat,
				n - $elm$core$String$length(string),
				$elm$core$String$fromChar(_char)),
			string);
	});
var $author$project$Helper$durationToString = function (duration) {
	return A3(
		$elm$core$String$padLeft,
		2,
		_Utils_chr('0'),
		$elm$core$String$fromInt((duration / 60) | 0)) + (':' + A3(
		$elm$core$String$padLeft,
		2,
		_Utils_chr('0'),
		$elm$core$String$fromInt(
			A2($elm$core$Basics$modBy, 60, duration))));
};
var $author$project$Pages$Music$Album$Albumid_Int$materialButton = function (_v0) {
	var icon = _v0.a;
	var action = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 3)
			]),
		{
			label: $mdgriffith$elm_ui$Element$html(
				A2(
					icon,
					24,
					$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
			onPress: $elm$core$Maybe$Just(action)
		});
};
var $icidasset$elm_material_icons$Material$Icons$more_horiz = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M6 10c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm12 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm-6 0c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z')
				]),
			_List_Nil)
		]));
var $author$project$Colors$navHeaderBackground = A3($mdgriffith$elm_ui$Element$rgb255, 30, 33, 34);
var $elm$html$Html$Events$onDoubleClick = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'dblclick',
		$elm$json$Json$Decode$succeed(msg));
};
var $mdgriffith$elm_ui$Element$Events$onDoubleClick = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Events$onDoubleClick);
var $icidasset$elm_material_icons$Material$Icons$thumb_up = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0V0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M1 21h4V9H1v12zm22-11c0-1.1-.9-2-2-2h-6.31l.95-4.57.03-.32c0-.41-.17-.79-.44-1.06L14.17 1 7.59 7.59C7.22 7.95 7 8.45 7 9v10c0 1.1.9 2 2 2h9c.83 0 1.54-.5 1.84-1.22l3.02-7.05c.09-.23.14-.47.14-.73v-2z')
				]),
			_List_Nil)
		]));
var $author$project$Pages$Music$Album$Albumid_Int$view = function (model) {
	return {
		body: _List_fromArray(
			[
				function () {
				var _v0 = model.album;
				if (_v0.$ === 'Nothing') {
					return A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
							]),
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$text(
								$elm$core$String$fromInt(model.albumid))
							]));
				} else {
					var album = _v0.a;
					return A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
							]),
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Element$row,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height(
										$mdgriffith$elm_ui$Element$fillPortion(1)),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$navHeaderBackground)
									]),
								_List_fromArray(
									[
										A2(
										$mdgriffith$elm_ui$Element$image,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$height(
												A2($mdgriffith$elm_ui$Element$maximum, 240, $mdgriffith$elm_ui$Element$fill)),
												$mdgriffith$elm_ui$Element$width(
												A2(
													$mdgriffith$elm_ui$Element$maximum,
													240,
													$mdgriffith$elm_ui$Element$fillPortion(1)))
											]),
										{
											description: 'Thumbnail',
											src: A3(
												$elm$url$Url$Builder$crossOrigin,
												'http://localhost:8080',
												_List_fromArray(
													[
														'image',
														$elm$url$Url$percentEncode(album.thumbnail)
													]),
												_List_Nil)
										}),
										A2(
										$mdgriffith$elm_ui$Element$column,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$alignTop,
												$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
												$mdgriffith$elm_ui$Element$width(
												$mdgriffith$elm_ui$Element$fillPortion(7))
											]),
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$text(album.label),
												A2(
												$mdgriffith$elm_ui$Element$row,
												_List_Nil,
												_List_fromArray(
													[
														$mdgriffith$elm_ui$Element$text('Artist(s): '),
														A2(
														$mdgriffith$elm_ui$Element$row,
														_List_Nil,
														A2(
															$elm$core$List$map,
															function (artist) {
																return $mdgriffith$elm_ui$Element$text(artist);
															},
															album.artist))
													])),
												A2(
												$mdgriffith$elm_ui$Element$row,
												_List_Nil,
												_List_fromArray(
													[
														$mdgriffith$elm_ui$Element$text('Genre: '),
														A2(
														$mdgriffith$elm_ui$Element$row,
														_List_Nil,
														A2(
															$elm$core$List$map,
															function (genre) {
																return $mdgriffith$elm_ui$Element$text(genre);
															},
															album.genre))
													]))
											]))
									])),
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height(
										$mdgriffith$elm_ui$Element$fillPortion(5)),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
										A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
										A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7)
									]),
								A2(
									$elm$core$List$map,
									function (song) {
										return A2(
											$mdgriffith$elm_ui$Element$row,
											_List_fromArray(
												[
													$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
													A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
													$mdgriffith$elm_ui$Element$Background$color(
													A3($mdgriffith$elm_ui$Element$rgb, 0.2, 0.2, 0.2)),
													$mdgriffith$elm_ui$Element$mouseOver(
													_List_fromArray(
														[
															$mdgriffith$elm_ui$Element$Background$color(
															A3($mdgriffith$elm_ui$Element$rgb, 0.4, 0.4, 0.4))
														])),
													$mdgriffith$elm_ui$Element$Events$onDoubleClick(
													$author$project$Pages$Music$Album$Albumid_Int$SetCurrentlyPlaying(song))
												]),
											_List_fromArray(
												[
													$author$project$Pages$Music$Album$Albumid_Int$materialButton(
													_Utils_Tuple2(
														$icidasset$elm_material_icons$Material$Icons$play_arrow,
														$author$project$Pages$Music$Album$Albumid_Int$SetCurrentlyPlaying(song))),
													$author$project$Pages$Music$Album$Albumid_Int$materialButton(
													_Utils_Tuple2(
														$icidasset$elm_material_icons$Material$Icons$thumb_up,
														$author$project$Pages$Music$Album$Albumid_Int$SetCurrentlyPlaying(song))),
													A2(
													$mdgriffith$elm_ui$Element$el,
													_List_fromArray(
														[
															$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$background)
														]),
													$mdgriffith$elm_ui$Element$text(song.label)),
													A2(
													$mdgriffith$elm_ui$Element$row,
													_List_fromArray(
														[$mdgriffith$elm_ui$Element$alignRight]),
													A2(
														$elm$core$List$map,
														function (artist) {
															return A2(
																$mdgriffith$elm_ui$Element$el,
																_List_fromArray(
																	[
																		$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$background),
																		A2($mdgriffith$elm_ui$Element$paddingXY, 5, 0)
																	]),
																$mdgriffith$elm_ui$Element$text(artist));
														},
														song.artist)),
													A2(
													$mdgriffith$elm_ui$Element$el,
													_List_fromArray(
														[
															$mdgriffith$elm_ui$Element$alignRight,
															$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$background)
														]),
													$mdgriffith$elm_ui$Element$text(
														$author$project$Helper$durationToString(song.duration))),
													$author$project$Pages$Music$Album$Albumid_Int$materialButton(
													_Utils_Tuple2(
														$icidasset$elm_material_icons$Material$Icons$more_horiz,
														$author$project$Pages$Music$Album$Albumid_Int$SetCurrentlyPlaying(song)))
												]));
									},
									model.song_list))
							]));
				}
			}()
			]),
		title: 'Music.Album.Albumid_Int'
	};
};
var $author$project$Pages$Music$Album$Albumid_Int$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Music$Album$Albumid_Int$init, load: $author$project$Pages$Music$Album$Albumid_Int$load, save: $author$project$Pages$Music$Album$Albumid_Int$save, subscriptions: $author$project$Pages$Music$Album$Albumid_Int$subscriptions, update: $author$project$Pages$Music$Album$Albumid_Int$update, view: $author$project$Pages$Music$Album$Albumid_Int$view});
var $author$project$Pages$Music$Albums$init = F2(
	function (shared, url) {
		return _Utils_Tuple2(
			{album_list: shared.album_list, route: url.route},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Albums$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Albums$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Music$Albums$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Music$Albums$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Albums$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavMusic$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								A2($mdgriffith$elm_ui$Element$paddingXY, 0, 0),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
								$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
							]),
						_List_fromArray(
							[
								$author$project$Components$SectionHeader$viewAlbums(model.album_list)
							]))
					]))
			]),
		title: 'Music.Artists'
	};
};
var $author$project$Pages$Music$Albums$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Music$Albums$init, load: $author$project$Pages$Music$Albums$load, save: $author$project$Pages$Music$Albums$save, subscriptions: $author$project$Pages$Music$Albums$subscriptions, update: $author$project$Pages$Music$Albums$update, view: $author$project$Pages$Music$Albums$view});
var $author$project$Pages$Music$Artist$Artistid_Int$checkArtistId = F2(
	function (firstId, artist) {
		return _Utils_eq(firstId, artist.artistid) ? true : false;
	});
var $author$project$Pages$Music$Artist$Artistid_Int$getArtist = F2(
	function (id, artistlist) {
		return $elm$core$List$head(
			A2(
				$elm$core$List$filter,
				function (artist) {
					return A2($author$project$Pages$Music$Artist$Artistid_Int$checkArtistId, id, artist);
				},
				artistlist));
	});
var $author$project$Pages$Music$Artist$Artistid_Int$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{
				album_list: shared.album_list,
				artist: A2($author$project$Pages$Music$Artist$Artistid_Int$getArtist, params.artistid, shared.artist_list),
				artistid: params.artistid,
				song_list: shared.song_list
			},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Artist$Artistid_Int$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Artist$Artistid_Int$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Music$Artist$Artistid_Int$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Music$Artist$Artistid_Int$update = F2(
	function (msg, model) {
		var song = msg.a;
		return _Utils_Tuple2(
			model,
			$author$project$Shared$sendActions(
				_List_fromArray(
					[
						'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
						'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": ' + ($elm$core$String$fromInt(song.songid) + '}}}'),
						'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
					])));
	});
var $author$project$Pages$Music$Artist$Artistid_Int$SetCurrentlyPlaying = function (a) {
	return {$: 'SetCurrentlyPlaying', a: a};
};
var $author$project$Pages$Music$Artist$Artistid_Int$materialButton = function (_v0) {
	var icon = _v0.a;
	var action = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 3)
			]),
		{
			label: $mdgriffith$elm_ui$Element$html(
				A2(
					icon,
					24,
					$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
			onPress: $elm$core$Maybe$Just(action)
		});
};
var $author$project$Pages$Music$Artist$Artistid_Int$view = function (model) {
	return {
		body: _List_fromArray(
			[
				function () {
				var _v0 = model.artist;
				if (_v0.$ === 'Nothing') {
					return A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
							]),
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$text(
								$elm$core$String$fromInt(model.artistid))
							]));
				} else {
					var artist = _v0.a;
					return A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
							]),
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Element$row,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height(
										$mdgriffith$elm_ui$Element$fillPortion(1)),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$navHeaderBackground)
									]),
								_List_fromArray(
									[
										A2(
										$mdgriffith$elm_ui$Element$image,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$height(
												A2(
													$mdgriffith$elm_ui$Element$maximum,
													240,
													A2($mdgriffith$elm_ui$Element$minimum, 240, $mdgriffith$elm_ui$Element$fill))),
												$mdgriffith$elm_ui$Element$width(
												A2(
													$mdgriffith$elm_ui$Element$maximum,
													240,
													$mdgriffith$elm_ui$Element$fillPortion(1)))
											]),
										{
											description: 'Thumbnail',
											src: A3(
												$elm$url$Url$Builder$crossOrigin,
												'http://localhost:8080',
												_List_fromArray(
													[
														'image',
														$elm$url$Url$percentEncode(artist.thumbnail)
													]),
												_List_Nil)
										}),
										A2(
										$mdgriffith$elm_ui$Element$column,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$alignTop,
												$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
												$mdgriffith$elm_ui$Element$width(
												$mdgriffith$elm_ui$Element$fillPortion(7)),
												A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5)
											]),
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$text(artist.label),
												A2(
												$mdgriffith$elm_ui$Element$row,
												_List_Nil,
												_List_fromArray(
													[
														$mdgriffith$elm_ui$Element$text('Buttons')
													]))
											]))
									])),
								function () {
								var _v1 = model.artist;
								if (_v1.$ === 'Nothing') {
									return A2(
										$mdgriffith$elm_ui$Element$el,
										_List_Nil,
										$mdgriffith$elm_ui$Element$text(''));
								} else {
									var art = _v1.a;
									return A2(
										$mdgriffith$elm_ui$Element$column,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
												$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
												A2($mdgriffith$elm_ui$Element$spacingXY, 5, 5)
											]),
										A2(
											$elm$core$List$map,
											function (album) {
												return A2(
													$mdgriffith$elm_ui$Element$row,
													_List_fromArray(
														[
															$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
															$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
														]),
													_List_fromArray(
														[
															A2(
															$mdgriffith$elm_ui$Element$column,
															_List_fromArray(
																[
																	$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
																	$mdgriffith$elm_ui$Element$width(
																	$mdgriffith$elm_ui$Element$fillPortion(1)),
																	A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5)
																]),
															_List_fromArray(
																[
																	function () {
																	var _v2 = album.thumbnail;
																	if (_v2 === '') {
																		return A2(
																			$mdgriffith$elm_ui$Element$image,
																			_List_fromArray(
																				[
																					$mdgriffith$elm_ui$Element$width(
																					$mdgriffith$elm_ui$Element$fillPortion(1)),
																					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
																				]),
																			{description: 'Hero Image', src: 'https://via.placeholder.com/170'});
																	} else {
																		return A2(
																			$mdgriffith$elm_ui$Element$column,
																			_List_fromArray(
																				[
																					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
																					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
																					A2($mdgriffith$elm_ui$Element$spacingXY, 5, 5)
																				]),
																			_List_fromArray(
																				[
																					A2(
																					$mdgriffith$elm_ui$Element$el,
																					_List_fromArray(
																						[
																							$mdgriffith$elm_ui$Element$below(
																							$mdgriffith$elm_ui$Element$text(album.label))
																						]),
																					A2(
																						$mdgriffith$elm_ui$Element$image,
																						_List_fromArray(
																							[
																								$mdgriffith$elm_ui$Element$width(
																								$mdgriffith$elm_ui$Element$fillPortion(1)),
																								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
																							]),
																						{
																							description: 'Thumbnail',
																							src: A3(
																								$elm$url$Url$Builder$crossOrigin,
																								'http://localhost:8080',
																								_List_fromArray(
																									[
																										'image',
																										$elm$url$Url$percentEncode(album.thumbnail)
																									]),
																								_List_Nil)
																						}))
																				]));
																	}
																}()
																])),
															A2(
															$mdgriffith$elm_ui$Element$column,
															_List_fromArray(
																[
																	$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
																	$mdgriffith$elm_ui$Element$width(
																	$mdgriffith$elm_ui$Element$fillPortion(3)),
																	A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
																	A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7)
																]),
															A2(
																$elm$core$List$map,
																function (song) {
																	return A2(
																		$mdgriffith$elm_ui$Element$row,
																		_List_fromArray(
																			[
																				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
																				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
																				$mdgriffith$elm_ui$Element$Background$color(
																				A3($mdgriffith$elm_ui$Element$rgb, 0.2, 0.2, 0.2)),
																				$mdgriffith$elm_ui$Element$mouseOver(
																				_List_fromArray(
																					[
																						$mdgriffith$elm_ui$Element$Background$color(
																						A3($mdgriffith$elm_ui$Element$rgb, 0.4, 0.4, 0.4))
																					])),
																				$mdgriffith$elm_ui$Element$Events$onDoubleClick(
																				$author$project$Pages$Music$Artist$Artistid_Int$SetCurrentlyPlaying(song))
																			]),
																		_List_fromArray(
																			[
																				$author$project$Pages$Music$Artist$Artistid_Int$materialButton(
																				_Utils_Tuple2(
																					$icidasset$elm_material_icons$Material$Icons$play_arrow,
																					$author$project$Pages$Music$Artist$Artistid_Int$SetCurrentlyPlaying(song))),
																				$author$project$Pages$Music$Artist$Artistid_Int$materialButton(
																				_Utils_Tuple2(
																					$icidasset$elm_material_icons$Material$Icons$thumb_up,
																					$author$project$Pages$Music$Artist$Artistid_Int$SetCurrentlyPlaying(song))),
																				A2(
																				$mdgriffith$elm_ui$Element$el,
																				_List_fromArray(
																					[
																						$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$background)
																					]),
																				$mdgriffith$elm_ui$Element$text(song.label)),
																				A2(
																				$mdgriffith$elm_ui$Element$row,
																				_List_fromArray(
																					[$mdgriffith$elm_ui$Element$alignRight]),
																				A2(
																					$elm$core$List$map,
																					function (songartist) {
																						return A2(
																							$mdgriffith$elm_ui$Element$el,
																							_List_fromArray(
																								[
																									$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$background),
																									A2($mdgriffith$elm_ui$Element$paddingXY, 5, 0)
																								]),
																							$mdgriffith$elm_ui$Element$text(songartist));
																					},
																					song.artist)),
																				A2(
																				$mdgriffith$elm_ui$Element$el,
																				_List_fromArray(
																					[
																						$mdgriffith$elm_ui$Element$alignRight,
																						$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$background)
																					]),
																				$mdgriffith$elm_ui$Element$text(
																					$author$project$Helper$durationToString(song.duration))),
																				$author$project$Pages$Music$Artist$Artistid_Int$materialButton(
																				_Utils_Tuple2(
																					$icidasset$elm_material_icons$Material$Icons$more_horiz,
																					$author$project$Pages$Music$Artist$Artistid_Int$SetCurrentlyPlaying(song)))
																			]));
																},
																A2(
																	$elm$core$List$filter,
																	function (song) {
																		return _Utils_eq(song.albumid, album.albumid);
																	},
																	model.song_list)))
														]));
											},
											A2(
												$elm$core$List$filter,
												function (album) {
													return A2($elm$core$List$member, art.label, album.artist);
												},
												model.album_list)));
								}
							}()
							]));
				}
			}()
			]),
		title: 'Music.Artist.Artistid_Int'
	};
};
var $author$project$Pages$Music$Artist$Artistid_Int$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Music$Artist$Artistid_Int$init, load: $author$project$Pages$Music$Artist$Artistid_Int$load, save: $author$project$Pages$Music$Artist$Artistid_Int$save, subscriptions: $author$project$Pages$Music$Artist$Artistid_Int$subscriptions, update: $author$project$Pages$Music$Artist$Artistid_Int$update, view: $author$project$Pages$Music$Artist$Artistid_Int$view});
var $author$project$Pages$Music$Artists$init = F2(
	function (shared, url) {
		return _Utils_Tuple2(
			{artist_list: shared.artist_list, route: url.route},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Artists$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Artists$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Music$Artists$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Music$Artists$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Components$SectionHeader$artistLabel = function (artist) {
	return A2(
		$mdgriffith$elm_ui$Element$link,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
				A2($mdgriffith$elm_ui$Element$paddingXY, 7, 16),
				$mdgriffith$elm_ui$Element$Font$center,
				$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$black)
			]),
		{
			label: $mdgriffith$elm_ui$Element$text(artist.label),
			url: $author$project$Spa$Generated$Route$toString(
				$author$project$Spa$Generated$Route$Music__Artist__Artistid_Int(
					{artistid: artist.artistid}))
		});
};
var $author$project$Components$SectionHeader$viewArtists = function (artistlist) {
	return A2(
		$mdgriffith$elm_ui$Element$wrappedRow,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
				A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7)
			]),
		A2(
			$elm$core$List$map,
			function (artist) {
				return A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
							$mdgriffith$elm_ui$Element$Background$color(
							A3($mdgriffith$elm_ui$Element$rgb, 1, 1, 1)),
							$mdgriffith$elm_ui$Element$mouseOver(
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$sidebar)
								])),
							$mdgriffith$elm_ui$Element$height(
							A2(
								$mdgriffith$elm_ui$Element$maximum,
								170,
								A2($mdgriffith$elm_ui$Element$minimum, 170, $mdgriffith$elm_ui$Element$fill))),
							$mdgriffith$elm_ui$Element$width(
							A2(
								$mdgriffith$elm_ui$Element$maximum,
								280,
								A2($mdgriffith$elm_ui$Element$minimum, 280, $mdgriffith$elm_ui$Element$fill))),
							$mdgriffith$elm_ui$Element$Border$rounded(3),
							$mdgriffith$elm_ui$Element$clipX
						]),
					_List_fromArray(
						[
							function () {
							var _v0 = artist.thumbnail;
							if (_v0 === '') {
								return A2(
									$mdgriffith$elm_ui$Element$image,
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
											$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
											$mdgriffith$elm_ui$Element$inFront(
											$author$project$Components$SectionHeader$artistLabel(artist))
										]),
									{description: 'Hero Image', src: 'https://via.placeholder.com/170'});
							} else {
								return A2(
									$mdgriffith$elm_ui$Element$image,
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
											$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
											$mdgriffith$elm_ui$Element$inFront(
											$author$project$Components$SectionHeader$artistLabel(artist))
										]),
									{
										description: 'Thumbnail',
										src: A3(
											$elm$url$Url$Builder$crossOrigin,
											'http://localhost:8080',
											_List_fromArray(
												[
													'image',
													$elm$url$Url$percentEncode(artist.thumbnail)
												]),
											_List_Nil)
									});
							}
						}(),
							$author$project$Components$SectionHeader$artistLabel(artist)
						]));
			},
			artistlist));
};
var $author$project$Pages$Music$Artists$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavMusic$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								A2($mdgriffith$elm_ui$Element$paddingXY, 0, 0),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
								$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
							]),
						_List_fromArray(
							[
								$author$project$Components$SectionHeader$viewArtists(model.artist_list)
							]))
					]))
			]),
		title: 'Music.Artists'
	};
};
var $author$project$Pages$Music$Artists$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Music$Artists$init, load: $author$project$Pages$Music$Artists$load, save: $author$project$Pages$Music$Artists$save, subscriptions: $author$project$Pages$Music$Artists$subscriptions, update: $author$project$Pages$Music$Artists$update, view: $author$project$Pages$Music$Artists$view});
var $author$project$Pages$Music$Genre$Genre_String$parseGenre = function (string) {
	if (string.$ === 'Nothing') {
		return 'None';
	} else {
		var str = string.a;
		return str;
	}
};
var $elm_community$list_extra$List$Extra$uniqueHelp = F4(
	function (f, existing, remaining, accumulator) {
		uniqueHelp:
		while (true) {
			if (!remaining.b) {
				return $elm$core$List$reverse(accumulator);
			} else {
				var first = remaining.a;
				var rest = remaining.b;
				var computedFirst = f(first);
				if (A2($elm$core$Set$member, computedFirst, existing)) {
					var $temp$f = f,
						$temp$existing = existing,
						$temp$remaining = rest,
						$temp$accumulator = accumulator;
					f = $temp$f;
					existing = $temp$existing;
					remaining = $temp$remaining;
					accumulator = $temp$accumulator;
					continue uniqueHelp;
				} else {
					var $temp$f = f,
						$temp$existing = A2($elm$core$Set$insert, computedFirst, existing),
						$temp$remaining = rest,
						$temp$accumulator = A2($elm$core$List$cons, first, accumulator);
					f = $temp$f;
					existing = $temp$existing;
					remaining = $temp$remaining;
					accumulator = $temp$accumulator;
					continue uniqueHelp;
				}
			}
		}
	});
var $elm_community$list_extra$List$Extra$unique = function (list) {
	return A4($elm_community$list_extra$List$Extra$uniqueHelp, $elm$core$Basics$identity, $elm$core$Set$empty, list, _List_Nil);
};
var $author$project$Pages$Music$Genre$Genre_String$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{
				album_list: A2(
					$elm$core$List$filter,
					function (album) {
						return A2($elm$core$List$member, params.genre, album.genre);
					},
					shared.album_list),
				artist_list: A2(
					$elm$core$List$filter,
					function (artist) {
						return A2(
							$elm$core$List$member,
							artist.label,
							$elm_community$list_extra$List$Extra$unique(
								A2(
									$elm$core$List$concatMap,
									function (song) {
										return song.artist;
									},
									A2(
										$elm$core$List$filter,
										function (song) {
											return A2($elm$core$List$member, params.genre, song.genre);
										},
										shared.song_list))));
					},
					shared.artist_list),
				artist_string_list: $elm_community$list_extra$List$Extra$unique(
					A2(
						$elm$core$List$concatMap,
						function (song) {
							return song.artist;
						},
						A2(
							$elm$core$List$filter,
							function (song) {
								return A2($elm$core$List$member, params.genre, song.genre);
							},
							shared.song_list))),
				genre: $author$project$Pages$Music$Genre$Genre_String$parseGenre(
					$elm$url$Url$percentDecode(params.genre)),
				route: $author$project$Spa$Generated$Route$Top,
				song_list: A2(
					$elm$core$List$filter,
					function (song) {
						return A2($elm$core$List$member, params.genre, song.genre);
					},
					shared.song_list)
			},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Genre$Genre_String$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Genre$Genre_String$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Music$Genre$Genre_String$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Music$Genre$Genre_String$update = F2(
	function (msg, model) {
		if (msg.$ === 'SetCurrentlyPlaying') {
			var song = msg.a;
			return _Utils_Tuple2(
				model,
				$author$project$Shared$sendActions(
					_List_fromArray(
						[
							'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
							'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": ' + ($elm$core$String$fromInt(song.songid) + '}}}'),
							'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
						])));
		} else {
			return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
		}
	});
var $author$project$Pages$Music$Genre$Genre_String$SetCurrentlyPlaying = function (a) {
	return {$: 'SetCurrentlyPlaying', a: a};
};
var $author$project$Pages$Music$Genre$Genre_String$materialButton = function (_v0) {
	var icon = _v0.a;
	var action = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 3)
			]),
		{
			label: $mdgriffith$elm_ui$Element$html(
				A2(
					icon,
					24,
					$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
			onPress: $elm$core$Maybe$Just(action)
		});
};
var $author$project$Pages$Music$Genre$Genre_String$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavMusic$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								A2($mdgriffith$elm_ui$Element$paddingXY, 0, 0),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
								$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
							]),
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$greyscaleGray)
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, model.genre + ' Artists', $elm$core$Maybe$Nothing, false, _List_Nil),
										$author$project$Components$SectionHeader$viewArtists(model.artist_list)
									])),
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, model.genre + ' Albums', $elm$core$Maybe$Nothing, false, _List_Nil),
										$author$project$Components$SectionHeader$viewAlbums(model.album_list)
									])),
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$alignBottom
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, model.genre + ' Songs', $elm$core$Maybe$Nothing, false, _List_Nil),
										A2(
										$mdgriffith$elm_ui$Element$column,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
												$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
												A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
												A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7)
											]),
										A2(
											$elm$core$List$map,
											function (song) {
												return A2(
													$mdgriffith$elm_ui$Element$row,
													_List_fromArray(
														[
															$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
															A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
															$mdgriffith$elm_ui$Element$Background$color(
															A3($mdgriffith$elm_ui$Element$rgb, 0.2, 0.2, 0.2)),
															$mdgriffith$elm_ui$Element$mouseOver(
															_List_fromArray(
																[
																	$mdgriffith$elm_ui$Element$Background$color(
																	A3($mdgriffith$elm_ui$Element$rgb, 0.4, 0.4, 0.4))
																])),
															$mdgriffith$elm_ui$Element$Events$onDoubleClick(
															$author$project$Pages$Music$Genre$Genre_String$SetCurrentlyPlaying(song))
														]),
													_List_fromArray(
														[
															$author$project$Pages$Music$Genre$Genre_String$materialButton(
															_Utils_Tuple2(
																$icidasset$elm_material_icons$Material$Icons$play_arrow,
																$author$project$Pages$Music$Genre$Genre_String$SetCurrentlyPlaying(song))),
															$author$project$Pages$Music$Genre$Genre_String$materialButton(
															_Utils_Tuple2(
																$icidasset$elm_material_icons$Material$Icons$thumb_up,
																$author$project$Pages$Music$Genre$Genre_String$SetCurrentlyPlaying(song))),
															A2(
															$mdgriffith$elm_ui$Element$el,
															_List_fromArray(
																[
																	$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$background)
																]),
															$mdgriffith$elm_ui$Element$text(song.label)),
															A2(
															$mdgriffith$elm_ui$Element$row,
															_List_fromArray(
																[$mdgriffith$elm_ui$Element$alignRight]),
															A2(
																$elm$core$List$map,
																function (artist) {
																	return A2(
																		$mdgriffith$elm_ui$Element$el,
																		_List_fromArray(
																			[
																				$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$background),
																				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 0)
																			]),
																		$mdgriffith$elm_ui$Element$text(artist));
																},
																song.artist)),
															A2(
															$mdgriffith$elm_ui$Element$el,
															_List_fromArray(
																[
																	$mdgriffith$elm_ui$Element$alignRight,
																	$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$background)
																]),
															$mdgriffith$elm_ui$Element$text(
																$author$project$Helper$durationToString(song.duration))),
															$author$project$Pages$Music$Genre$Genre_String$materialButton(
															_Utils_Tuple2(
																$icidasset$elm_material_icons$Material$Icons$more_horiz,
																$author$project$Pages$Music$Genre$Genre_String$SetCurrentlyPlaying(song)))
														]));
											},
											model.song_list))
									]))
							]))
					]))
			]),
		title: 'Music.Genre_String'
	};
};
var $author$project$Pages$Music$Genre$Genre_String$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Music$Genre$Genre_String$init, load: $author$project$Pages$Music$Genre$Genre_String$load, save: $author$project$Pages$Music$Genre$Genre_String$save, subscriptions: $author$project$Pages$Music$Genre$Genre_String$subscriptions, update: $author$project$Pages$Music$Genre$Genre_String$update, view: $author$project$Pages$Music$Genre$Genre_String$view});
var $author$project$Pages$Music$Genres$init = F2(
	function (shared, url) {
		return _Utils_Tuple2(
			{currentlyPlaying: shared.currentlyPlaying, genre_list: shared.genre_list, route: url.route},
			$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "AudioLibrary.GetSongs", "params": { "limits": { "start" : 0, "end": 25 }, "properties": [ "artist", "duration", "album", "track" ], "sort": { "order": "ascending", "method": "track", "ignorearticle": true } }, "id": "libSongs"}'));
	});
var $author$project$Pages$Music$Genres$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{genre_list: shared.genre_list}),
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Genres$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Music$Genres$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Music$Genres$update = F2(
	function (msg, model) {
		var song = msg.a;
		return _Utils_Tuple2(
			model,
			$author$project$Shared$sendActions(
				_List_fromArray(
					[
						'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
						'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": ' + ($elm$core$String$fromInt(song.songid) + '}}}'),
						'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
					])));
	});
var $mdgriffith$elm_ui$Internal$Model$boxShadowClass = function (shadow) {
	return $elm$core$String$concat(
		_List_fromArray(
			[
				shadow.inset ? 'box-inset' : 'box-',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.offset.a) + 'px',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.offset.b) + 'px',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.blur) + 'px',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.size) + 'px',
				$mdgriffith$elm_ui$Internal$Model$formatColorClass(shadow.color)
			]));
};
var $mdgriffith$elm_ui$Internal$Flag$shadows = $mdgriffith$elm_ui$Internal$Flag$flag(19);
var $mdgriffith$elm_ui$Element$Border$shadow = function (almostShade) {
	var shade = {blur: almostShade.blur, color: almostShade.color, inset: false, offset: almostShade.offset, size: almostShade.size};
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$shadows,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Single,
			$mdgriffith$elm_ui$Internal$Model$boxShadowClass(shade),
			'box-shadow',
			$mdgriffith$elm_ui$Internal$Model$formatBoxShadow(shade)));
};
var $mdgriffith$elm_ui$Element$Border$glow = F2(
	function (clr, size) {
		return $mdgriffith$elm_ui$Element$Border$shadow(
			{
				blur: size * 2,
				color: clr,
				offset: _Utils_Tuple2(0, 0),
				size: size
			});
	});
var $elm$core$List$sort = function (xs) {
	return A2($elm$core$List$sortBy, $elm$core$Basics$identity, xs);
};
var $author$project$Pages$Music$Genres$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavMusic$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$wrappedRow,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background),
								A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7)
							]),
						A2(
							$elm$core$List$map,
							function (genre) {
								return A2(
									$mdgriffith$elm_ui$Element$column,
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Element$Border$glow, $author$project$Colors$black, 0.04),
											$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$white),
											$mdgriffith$elm_ui$Element$mouseOver(
											_List_fromArray(
												[
													$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$sidebar)
												])),
											$mdgriffith$elm_ui$Element$height(
											A2(
												$mdgriffith$elm_ui$Element$maximum,
												50,
												A2($mdgriffith$elm_ui$Element$minimum, 50, $mdgriffith$elm_ui$Element$fill))),
											$mdgriffith$elm_ui$Element$width(
											A2(
												$mdgriffith$elm_ui$Element$maximum,
												185,
												A2($mdgriffith$elm_ui$Element$minimum, 185, $mdgriffith$elm_ui$Element$fill))),
											$mdgriffith$elm_ui$Element$Border$rounded(2)
										]),
									_List_fromArray(
										[
											A2(
											$mdgriffith$elm_ui$Element$link,
											_List_fromArray(
												[
													$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
													$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
													A2($mdgriffith$elm_ui$Element$paddingXY, 7, 16)
												]),
											{
												label: $mdgriffith$elm_ui$Element$text(genre),
												url: $author$project$Spa$Generated$Route$toString(
													$author$project$Spa$Generated$Route$Music__Genre__Genre_String(
														{
															genre: $elm$url$Url$percentEncode(genre)
														}))
											})
										]));
							},
							$elm$core$List$sort(model.genre_list)))
					]))
			]),
		title: 'Music.Genres'
	};
};
var $author$project$Pages$Music$Genres$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Music$Genres$init, load: $author$project$Pages$Music$Genres$load, save: $author$project$Pages$Music$Genres$save, subscriptions: $author$project$Pages$Music$Genres$subscriptions, update: $author$project$Pages$Music$Genres$update, view: $author$project$Pages$Music$Genres$view});
var $author$project$Pages$Music$Top$Top$init = F2(
	function (shared, _v0) {
		var route = _v0.route;
		return _Utils_Tuple2(
			{currentlyPlaying: shared.currentlyPlaying, route: route, song_list: shared.song_list},
			$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "AudioLibrary.GetSongs", "params": { "limits": { "start" : 0, "end": 25 }, "properties": [ "artist", "duration", "album", "track" ], "sort": { "order": "ascending", "method": "track", "ignorearticle": true } }, "id": "libSongs"}'));
	});
var $author$project$Pages$Music$Top$Top$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{song_list: shared.song_list}),
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Top$Top$save = F2(
	function (model, shared) {
		return _Utils_update(
			shared,
			{currentlyPlaying: model.currentlyPlaying, song_list: model.song_list});
	});
var $author$project$Pages$Music$Top$Top$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Music$Top$Top$update = F2(
	function (msg, model) {
		var song = msg.a;
		return _Utils_Tuple2(
			model,
			$author$project$Shared$sendActions(
				_List_fromArray(
					[
						'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
						'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"songid": ' + ($elm$core$String$fromInt(song.songid) + '}}}'),
						'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
					])));
	});
var $author$project$Pages$Music$Top$Top$SetCurrentlyPlaying = function (a) {
	return {$: 'SetCurrentlyPlaying', a: a};
};
var $author$project$Pages$Music$Top$Top$materialButton = function (_v0) {
	var icon = _v0.a;
	var action = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 3)
			]),
		{
			label: $mdgriffith$elm_ui$Element$html(
				A2(
					icon,
					24,
					$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
			onPress: $elm$core$Maybe$Just(action)
		});
};
var $author$project$Pages$Music$Top$Top$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavMusic$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7)
							]),
						A2(
							$elm$core$List$append,
							_List_fromArray(
								[
									A4(
									$author$project$Components$SectionHeader$view,
									'Top Songs',
									$elm$core$Maybe$Nothing,
									false,
									_List_fromArray(
										[
											{action: $elm$core$Maybe$Nothing, title: 'Toggle select all'}
										]))
								]),
							A2(
								$elm$core$List$map,
								function (song) {
									return A2(
										$mdgriffith$elm_ui$Element$row,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
												A2($mdgriffith$elm_ui$Element$paddingXY, 5, 5),
												$mdgriffith$elm_ui$Element$Background$color(
												A3($mdgriffith$elm_ui$Element$rgb, 0.2, 0.2, 0.2)),
												$mdgriffith$elm_ui$Element$mouseOver(
												_List_fromArray(
													[
														$mdgriffith$elm_ui$Element$Background$color(
														A3($mdgriffith$elm_ui$Element$rgb, 0.4, 0.4, 0.4))
													])),
												$mdgriffith$elm_ui$Element$Events$onDoubleClick(
												$author$project$Pages$Music$Top$Top$SetCurrentlyPlaying(song))
											]),
										_List_fromArray(
											[
												$author$project$Pages$Music$Top$Top$materialButton(
												_Utils_Tuple2(
													$icidasset$elm_material_icons$Material$Icons$play_arrow,
													$author$project$Pages$Music$Top$Top$SetCurrentlyPlaying(song))),
												$author$project$Pages$Music$Top$Top$materialButton(
												_Utils_Tuple2(
													$icidasset$elm_material_icons$Material$Icons$thumb_up,
													$author$project$Pages$Music$Top$Top$SetCurrentlyPlaying(song))),
												A2(
												$mdgriffith$elm_ui$Element$el,
												_List_fromArray(
													[
														$mdgriffith$elm_ui$Element$Font$color(
														A3($mdgriffith$elm_ui$Element$rgb, 0.8, 0.8, 0.8))
													]),
												$mdgriffith$elm_ui$Element$text(song.label)),
												A2(
												$mdgriffith$elm_ui$Element$row,
												_List_fromArray(
													[$mdgriffith$elm_ui$Element$alignRight]),
												A2(
													$elm$core$List$map,
													function (artist) {
														return A2(
															$mdgriffith$elm_ui$Element$el,
															_List_fromArray(
																[
																	$mdgriffith$elm_ui$Element$Font$color(
																	A3($mdgriffith$elm_ui$Element$rgb, 0.8, 0.8, 0.8)),
																	A2($mdgriffith$elm_ui$Element$paddingXY, 5, 0)
																]),
															$mdgriffith$elm_ui$Element$text(artist));
													},
													song.artist)),
												A2(
												$mdgriffith$elm_ui$Element$el,
												_List_fromArray(
													[
														$mdgriffith$elm_ui$Element$alignRight,
														$mdgriffith$elm_ui$Element$Font$color(
														A3($mdgriffith$elm_ui$Element$rgb, 0.8, 0.8, 0.8))
													]),
												$mdgriffith$elm_ui$Element$text(
													$author$project$Helper$durationToString(song.duration))),
												$author$project$Pages$Music$Top$Top$materialButton(
												_Utils_Tuple2(
													$icidasset$elm_material_icons$Material$Icons$more_horiz,
													$author$project$Pages$Music$Top$Top$SetCurrentlyPlaying(song)))
											]));
								},
								model.song_list)))
					]))
			]),
		title: 'Music'
	};
};
var $author$project$Pages$Music$Top$Top$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Music$Top$Top$init, load: $author$project$Pages$Music$Top$Top$load, save: $author$project$Pages$Music$Top$Top$save, subscriptions: $author$project$Pages$Music$Top$Top$subscriptions, update: $author$project$Pages$Music$Top$Top$update, view: $author$project$Pages$Music$Top$Top$view});
var $author$project$Pages$Music$Videos$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Videos$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Videos$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Music$Videos$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Music$Videos$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Music$Videos$view = function (model) {
	return {body: _List_Nil, title: 'Music.Videos'};
};
var $author$project$Pages$Music$Videos$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Music$Videos$init, load: $author$project$Pages$Music$Videos$load, save: $author$project$Pages$Music$Videos$save, subscriptions: $author$project$Pages$Music$Videos$subscriptions, update: $author$project$Pages$Music$Videos$update, view: $author$project$Pages$Music$Videos$view});
var $author$project$Pages$NotFound$view = function (_v0) {
	var params = _v0.params;
	return {
		body: _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$text('Page not found')
			]),
		title: '404'
	};
};
var $author$project$Pages$NotFound$page = $author$project$Spa$Page$static(
	{view: $author$project$Pages$NotFound$view});
var $author$project$Pages$Playlists$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{playlists: shared.playlists, showDialog: shared.showDialog},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Playlists$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Playlists$save = F2(
	function (model, shared) {
		return _Utils_update(
			shared,
			{showDialog: model.showDialog});
	});
var $author$project$Pages$Playlists$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Components$LayoutType$TextInputDialog = {$: 'TextInputDialog'};
var $author$project$Pages$Playlists$update = F2(
	function (msg, model) {
		if (msg.$ === 'NewPlaylist') {
			return _Utils_Tuple2(
				_Utils_update(
					model,
					{showDialog: $author$project$Components$LayoutType$TextInputDialog}),
				$elm$core$Platform$Cmd$none);
		} else {
			return _Utils_Tuple2(
				_Utils_update(
					model,
					{showDialog: $author$project$Components$LayoutType$None}),
				$elm$core$Platform$Cmd$none);
		}
	});
var $author$project$Pages$Playlists$NewPlaylist = {$: 'NewPlaylist'};
var $author$project$Components$VerticalNavPlaylists$isCurrentRoute = F2(
	function (route, currentRoute) {
		return _Utils_eq(route, currentRoute) ? $mdgriffith$elm_ui$Element$Font$color($author$project$Colors$navTextHover) : $mdgriffith$elm_ui$Element$Font$color($author$project$Colors$navText);
	});
var $author$project$Components$VerticalNavPlaylists$view = F4(
	function (header, currentRoute, links, newPlaylistMsg) {
		return A2(
			$mdgriffith$elm_ui$Element$column,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$fillPortion(1)),
					$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$greyscaleGray),
					$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$sidebar)
				]),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							A2($mdgriffith$elm_ui$Element$paddingXY, 16, 8),
							$mdgriffith$elm_ui$Element$spacing(16)
						]),
					_Utils_ap(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$text(
								$elm$core$String$toUpper(header))
							]),
						A2(
							$elm$core$List$map,
							function (a) {
								return A2(
									$mdgriffith$elm_ui$Element$link,
									_List_fromArray(
										[
											A2($author$project$Components$VerticalNavPlaylists$isCurrentRoute, a.route, currentRoute),
											A2($mdgriffith$elm_ui$Element$paddingXY, 16, 0)
										]),
									{
										label: $mdgriffith$elm_ui$Element$text(a.label),
										url: $author$project$Spa$Generated$Route$toString(a.route)
									});
							},
							links))),
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							A2($mdgriffith$elm_ui$Element$paddingXY, 16, 8),
							$mdgriffith$elm_ui$Element$spacing(16)
						]),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Element$el,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleGray),
									$mdgriffith$elm_ui$Element$mouseOver(
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleOuterSpace)
										]))
								]),
							A2(
								$mdgriffith$elm_ui$Element$Input$button,
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Element$paddingXY, 10, 10)
									]),
								{
									label: A2(
										$mdgriffith$elm_ui$Element$el,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$white)
											]),
										$mdgriffith$elm_ui$Element$text('New Playlist')),
									onPress: $elm$core$Maybe$Just(newPlaylistMsg)
								}))
						]))
				]));
	});
var $author$project$Pages$Playlists$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A4(
				$author$project$Components$VerticalNavPlaylists$view,
				'playlists',
				$author$project$Spa$Generated$Route$Top,
				A2(
					$elm$core$List$map,
					function (playlist) {
						return {
							label: playlist.name,
							route: $author$project$Spa$Generated$Route$Playlists__Name_String(
								{
									name: $elm$url$Url$percentEncode(playlist.name)
								})
						};
					},
					model.playlists.localPlaylists),
				$author$project$Pages$Playlists$NewPlaylist)
			]),
		title: 'Playlists'
	};
};
var $author$project$Pages$Playlists$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Playlists$init, load: $author$project$Pages$Playlists$load, save: $author$project$Pages$Playlists$save, subscriptions: $author$project$Pages$Playlists$subscriptions, update: $author$project$Pages$Playlists$update, view: $author$project$Pages$Playlists$view});
var $author$project$Pages$Playlists$Name_String$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Playlists$Name_String$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Playlists$Name_String$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Playlists$Name_String$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Playlists$Name_String$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Playlists$Name_String$view = function (model) {
	return {body: _List_Nil, title: 'Playlists.Name_String'};
};
var $author$project$Pages$Playlists$Name_String$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Playlists$Name_String$init, load: $author$project$Pages$Playlists$Name_String$load, save: $author$project$Pages$Playlists$Name_String$save, subscriptions: $author$project$Pages$Playlists$Name_String$subscriptions, update: $author$project$Pages$Playlists$Name_String$update, view: $author$project$Pages$Playlists$Name_String$view});
var $author$project$Spa$Page$element = function (page) {
	return {
		init: F2(
			function (_v0, params) {
				return page.init(params);
			}),
		load: $elm$core$Basics$always(
			A2($elm$core$Basics$composeR, $elm$core$Basics$identity, $author$project$Spa$Page$ignoreEffect)),
		save: $elm$core$Basics$always($elm$core$Basics$identity),
		subscriptions: page.subscriptions,
		update: F2(
			function (msg, model) {
				return A2(page.update, msg, model);
			}),
		view: page.view
	};
};
var $author$project$Pages$Settings$Addons$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Addons$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Addons$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Components$VerticalNavSettings$view = function (currentRoute) {
	return _List_fromArray(
		[
			A4(
			$author$project$Components$VerticalNav$view,
			'General',
			currentRoute,
			_List_fromArray(
				[
					{label: 'Web interface', route: $author$project$Spa$Generated$Route$Settings__Web},
					{label: 'Main Menu', route: $author$project$Spa$Generated$Route$Settings__Nav},
					{label: 'Add-ons', route: $author$project$Spa$Generated$Route$Settings__Addons},
					{label: 'Serach', route: $author$project$Spa$Generated$Route$Settings__Search}
				]),
			_List_Nil),
			A4(
			$author$project$Components$VerticalNav$view,
			'Kodi Settings',
			currentRoute,
			_List_fromArray(
				[
					{label: 'Games', route: $author$project$Spa$Generated$Route$Settings__Kodi__Games},
					{label: 'Interface', route: $author$project$Spa$Generated$Route$Settings__Kodi__Interface},
					{label: 'Media', route: $author$project$Spa$Generated$Route$Settings__Kodi__Media},
					{label: 'Player', route: $author$project$Spa$Generated$Route$Settings__Kodi__Player},
					{label: 'PVR & Live TV', route: $author$project$Spa$Generated$Route$Settings__Kodi__Pvr},
					{label: 'Services', route: $author$project$Spa$Generated$Route$Settings__Kodi__Services},
					{label: 'System', route: $author$project$Spa$Generated$Route$Settings__Kodi__System}
				]),
			_List_Nil)
		]);
};
var $author$project$Pages$Settings$Addons$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_Utils_ap(
					$author$project$Components$VerticalNavSettings$view(model.route),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Element$column,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
									$mdgriffith$elm_ui$Element$width(
									$mdgriffith$elm_ui$Element$fillPortion(6)),
									A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
									$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
								]),
							_List_Nil)
						])))
			]),
		title: 'Settings.Addons'
	};
};
var $author$project$Pages$Settings$Addons$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Addons$init, subscriptions: $author$project$Pages$Settings$Addons$subscriptions, update: $author$project$Pages$Settings$Addons$update, view: $author$project$Pages$Settings$Addons$view});
var $author$project$Pages$Settings$Kodi$Games$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Kodi$Games$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Kodi$Games$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Kodi$Games$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Kodi.Games'
	};
};
var $author$project$Pages$Settings$Kodi$Games$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Kodi$Games$init, subscriptions: $author$project$Pages$Settings$Kodi$Games$subscriptions, update: $author$project$Pages$Settings$Kodi$Games$update, view: $author$project$Pages$Settings$Kodi$Games$view});
var $author$project$Pages$Settings$Kodi$Interface$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Kodi$Interface$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Kodi$Interface$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Kodi$Interface$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Kodi.Interface'
	};
};
var $author$project$Pages$Settings$Kodi$Interface$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Kodi$Interface$init, subscriptions: $author$project$Pages$Settings$Kodi$Interface$subscriptions, update: $author$project$Pages$Settings$Kodi$Interface$update, view: $author$project$Pages$Settings$Kodi$Interface$view});
var $author$project$Pages$Settings$Kodi$Media$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Kodi$Media$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Kodi$Media$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Kodi$Media$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Kodi.Media'
	};
};
var $author$project$Pages$Settings$Kodi$Media$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Kodi$Media$init, subscriptions: $author$project$Pages$Settings$Kodi$Media$subscriptions, update: $author$project$Pages$Settings$Kodi$Media$update, view: $author$project$Pages$Settings$Kodi$Media$view});
var $author$project$Pages$Settings$Kodi$Player$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Kodi$Player$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Kodi$Player$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Kodi$Player$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Kodi.Player'
	};
};
var $author$project$Pages$Settings$Kodi$Player$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Kodi$Player$init, subscriptions: $author$project$Pages$Settings$Kodi$Player$subscriptions, update: $author$project$Pages$Settings$Kodi$Player$update, view: $author$project$Pages$Settings$Kodi$Player$view});
var $author$project$Pages$Settings$Kodi$Pvr$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Kodi$Pvr$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Kodi$Pvr$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Kodi$Pvr$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Kodi.Pvr'
	};
};
var $author$project$Pages$Settings$Kodi$Pvr$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Kodi$Pvr$init, subscriptions: $author$project$Pages$Settings$Kodi$Pvr$subscriptions, update: $author$project$Pages$Settings$Kodi$Pvr$update, view: $author$project$Pages$Settings$Kodi$Pvr$view});
var $author$project$Pages$Settings$Kodi$Services$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Kodi$Services$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Kodi$Services$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Kodi$Services$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Kodi.Services'
	};
};
var $author$project$Pages$Settings$Kodi$Services$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Kodi$Services$init, subscriptions: $author$project$Pages$Settings$Kodi$Services$subscriptions, update: $author$project$Pages$Settings$Kodi$Services$update, view: $author$project$Pages$Settings$Kodi$Services$view});
var $author$project$Pages$Settings$Kodi$System$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Kodi$System$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Kodi$System$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Kodi$System$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Kodi.System'
	};
};
var $author$project$Pages$Settings$Kodi$System$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Kodi$System$init, subscriptions: $author$project$Pages$Settings$Kodi$System$subscriptions, update: $author$project$Pages$Settings$Kodi$System$update, view: $author$project$Pages$Settings$Kodi$System$view});
var $author$project$Pages$Settings$Nav$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Nav$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Nav$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Nav$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Nav'
	};
};
var $author$project$Pages$Settings$Nav$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Nav$init, subscriptions: $author$project$Pages$Settings$Nav$subscriptions, update: $author$project$Pages$Settings$Nav$update, view: $author$project$Pages$Settings$Nav$view});
var $author$project$Pages$Settings$Search$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Search$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Search$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Search$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Search'
	};
};
var $author$project$Pages$Settings$Search$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Search$init, subscriptions: $author$project$Pages$Settings$Search$subscriptions, update: $author$project$Pages$Settings$Search$update, view: $author$project$Pages$Settings$Search$view});
var $author$project$Pages$Settings$Web$init = function (url) {
	return _Utils_Tuple2(
		{route: url.route},
		$elm$core$Platform$Cmd$none);
};
var $author$project$Pages$Settings$Web$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Settings$Web$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Settings$Web$view = function (model) {
	return {
		body: _Utils_ap(
			$author$project$Components$VerticalNavSettings$view(model.route),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$fillPortion(6)),
							A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
						]),
					_List_Nil)
				])),
		title: 'Settings.Web'
	};
};
var $author$project$Pages$Settings$Web$page = $author$project$Spa$Page$element(
	{init: $author$project$Pages$Settings$Web$init, subscriptions: $author$project$Pages$Settings$Web$subscriptions, update: $author$project$Pages$Settings$Web$update, view: $author$project$Pages$Settings$Web$view});
var $author$project$Pages$Thumbsup$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		return _Utils_Tuple2(
			{},
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Thumbsup$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Thumbsup$save = F2(
	function (model, shared) {
		return shared;
	});
var $author$project$Pages$Thumbsup$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Thumbsup$update = F2(
	function (msg, model) {
		return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Thumbsup$view = function (model) {
	return {body: _List_Nil, title: 'Thumbsup'};
};
var $author$project$Pages$Thumbsup$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Thumbsup$init, load: $author$project$Pages$Thumbsup$load, save: $author$project$Pages$Thumbsup$save, subscriptions: $author$project$Pages$Thumbsup$subscriptions, update: $author$project$Pages$Thumbsup$update, view: $author$project$Pages$Thumbsup$view});
var $author$project$Pages$Top$view = function (_v0) {
	var params = _v0.params;
	return {
		body: _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$text('Homepage')
			]),
		title: 'Homepage'
	};
};
var $author$project$Pages$Top$page = $author$project$Spa$Page$static(
	{view: $author$project$Pages$Top$view});
var $author$project$Pages$Tvshows$init = F2(
	function (shared, url) {
		return _Utils_Tuple2(
			{currentlyPlaying: shared.currentlyPlaying, route: url.route, tvshow_list: shared.tvshow_list},
			$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "VideoLibrary.GetMovies", "params": { "filter": {"field": "playcount", "operator": "is", "value": "0"}, "properties" : ["art", "rating", "thumbnail", "playcount", "file"], "sort": { "order": "ascending", "method": "label", "ignorearticle": true } }, "id": "libMovies"}'));
	});
var $author$project$Pages$Tvshows$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{tvshow_list: shared.tvshow_list}),
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Tvshows$save = F2(
	function (model, shared) {
		return _Utils_update(
			shared,
			{currentlyPlaying: model.currentlyPlaying, tvshow_list: model.tvshow_list});
	});
var $author$project$Pages$Tvshows$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Tvshows$update = F2(
	function (msg, model) {
		if (msg.$ === 'SetCurrentlyPlaying') {
			var tvshow = msg.a;
			return _Utils_Tuple2(
				model,
				$author$project$Shared$sendActions(
					_List_fromArray(
						[
							'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
							'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"tvshowid": ' + ($elm$core$String$fromInt(tvshow.tvshowid) + '}}}'),
							'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
						])));
		} else {
			return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
		}
	});
var $author$project$Pages$Tvshows$NoOp = {$: 'NoOp'};
var $author$project$Pages$Tvshows$materialButton = function (_v0) {
	var icon = _v0.a;
	var action = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 3),
				$mdgriffith$elm_ui$Element$Background$color(
				A3($mdgriffith$elm_ui$Element$rgb, 0.2, 0.2, 0.2))
			]),
		{
			label: $mdgriffith$elm_ui$Element$html(
				A2(
					icon,
					24,
					$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
			onPress: $elm$core$Maybe$Just(action)
		});
};
var $author$project$Pages$Tvshows$constructTvshowItem = function (tvshow) {
	return A2(
		$mdgriffith$elm_ui$Element$column,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$spacingXY, 5, 0),
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$image,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							150,
							A2($mdgriffith$elm_ui$Element$minimum, 150, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$height(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							200,
							A2($mdgriffith$elm_ui$Element$minimum, 200, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$inFront(
						A2(
							$mdgriffith$elm_ui$Element$row,
							_List_Nil,
							_List_fromArray(
								[
									$author$project$Pages$Tvshows$materialButton(
									_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$play_arrow, $author$project$Pages$Tvshows$NoOp))
								])))
					]),
				$elm$core$String$isEmpty(tvshow.thumbnail) ? {description: 'Hero Image', src: 'https://via.placeholder.com/70'} : {
					description: tvshow.label,
					src: A3(
						$elm$url$Url$Builder$crossOrigin,
						'http://localhost:8080',
						_List_fromArray(
							[
								'image',
								$elm$url$Url$percentEncode(tvshow.thumbnail)
							]),
						_List_Nil)
				}),
				A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alignBottom,
						$mdgriffith$elm_ui$Element$Background$color(
						A3($mdgriffith$elm_ui$Element$rgb, 1, 1, 1)),
						$mdgriffith$elm_ui$Element$width(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							150,
							A2($mdgriffith$elm_ui$Element$minimum, 150, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$clip
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0, 0, 0)),
								$mdgriffith$elm_ui$Element$Font$size(18)
							]),
						$mdgriffith$elm_ui$Element$text(tvshow.label)),
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
								$mdgriffith$elm_ui$Element$Font$size(18)
							]),
						$mdgriffith$elm_ui$Element$text('2020'))
					]))
			]));
};
var $author$project$Components$VerticalNavTvshows$view = function (currentRoute) {
	return A4(
		$author$project$Components$VerticalNav$view,
		'sections',
		currentRoute,
		_List_fromArray(
			[
				{label: 'TV shows', route: $author$project$Spa$Generated$Route$Tvshows__Recent},
				{label: 'All TV shows', route: $author$project$Spa$Generated$Route$Tvshows}
			]),
		_List_fromArray(
			[$author$project$Spa$Generated$Route$Tvshows]));
};
var $author$project$Pages$Tvshows$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavTvshows$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$wrappedRow,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								$mdgriffith$elm_ui$Element$Background$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0.8, 0.8, 0.8)),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 10)
							]),
						A2(
							$elm$core$List$map,
							function (tvshow) {
								return $author$project$Pages$Tvshows$constructTvshowItem(tvshow);
							},
							model.tvshow_list))
					]))
			]),
		title: 'TVShows'
	};
};
var $author$project$Pages$Tvshows$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Tvshows$init, load: $author$project$Pages$Tvshows$load, save: $author$project$Pages$Tvshows$save, subscriptions: $author$project$Pages$Tvshows$subscriptions, update: $author$project$Pages$Tvshows$update, view: $author$project$Pages$Tvshows$view});
var $author$project$Pages$Tvshows$Recent$init = F2(
	function (shared, url) {
		return _Utils_Tuple2(
			{currentlyPlaying: shared.currentlyPlaying, route: url.route, tvshow_list: shared.tvshow_list},
			$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "VideoLibrary.GetTvshows", "params": { "filter": {"field": "playcount", "operator": "is", "value": "0"}, "properties" : ["art", "rating", "thumbnail", "playcount", "file"], "sort": { "order": "ascending", "method": "label", "ignorearticle": true } }, "id": "libTvshows"}'));
	});
var $author$project$Pages$Tvshows$Recent$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{tvshow_list: shared.tvshow_list}),
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Tvshows$Recent$save = F2(
	function (model, shared) {
		return _Utils_update(
			shared,
			{currentlyPlaying: model.currentlyPlaying, tvshow_list: model.tvshow_list});
	});
var $author$project$Pages$Tvshows$Recent$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Tvshows$Recent$update = F2(
	function (msg, model) {
		if (msg.$ === 'SetCurrentlyPlaying') {
			var tvshow = msg.a;
			return _Utils_Tuple2(
				model,
				$author$project$Shared$sendActions(
					_List_fromArray(
						[
							'{"jsonrpc": "2.0", "id": 0, "method": "Playlist.Clear", "params": {"playlistid": 0}}',
							'{"jsonrpc": "2.0", "id": 1, "method": "Playlist.Add", "params": {"playlistid": 0, "item": {"tvshowid": ' + ($elm$core$String$fromInt(tvshow.tvshowid) + '}}}'),
							'{"jsonrpc": "2.0", "id": 0, "method": "Player.Open", "params": {"item": {"playlistid": 0}}}'
						])));
		} else {
			return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
		}
	});
var $author$project$Pages$Tvshows$Recent$NoOp = {$: 'NoOp'};
var $author$project$Pages$Tvshows$Recent$materialButton = function (_v0) {
	var icon = _v0.a;
	var action = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$paddingXY, 5, 3),
				$mdgriffith$elm_ui$Element$Background$color(
				A3($mdgriffith$elm_ui$Element$rgb, 0.2, 0.2, 0.2))
			]),
		{
			label: $mdgriffith$elm_ui$Element$html(
				A2(
					icon,
					24,
					$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
			onPress: $elm$core$Maybe$Just(action)
		});
};
var $author$project$Pages$Tvshows$Recent$constructTvshowItem = function (tvshow) {
	return A2(
		$mdgriffith$elm_ui$Element$column,
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Element$spacingXY, 5, 0),
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$image,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							150,
							A2($mdgriffith$elm_ui$Element$minimum, 150, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$height(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							200,
							A2($mdgriffith$elm_ui$Element$minimum, 200, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$inFront(
						A2(
							$mdgriffith$elm_ui$Element$row,
							_List_Nil,
							_List_fromArray(
								[
									$author$project$Pages$Tvshows$Recent$materialButton(
									_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$play_arrow, $author$project$Pages$Tvshows$Recent$NoOp))
								])))
					]),
				$elm$core$String$isEmpty(tvshow.thumbnail) ? {description: 'Hero Image', src: 'https://via.placeholder.com/70'} : {
					description: tvshow.label,
					src: A3(
						$elm$url$Url$Builder$crossOrigin,
						'http://localhost:8080',
						_List_fromArray(
							[
								'image',
								$elm$url$Url$percentEncode(tvshow.thumbnail)
							]),
						_List_Nil)
				}),
				A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alignBottom,
						$mdgriffith$elm_ui$Element$Background$color(
						A3($mdgriffith$elm_ui$Element$rgb, 1, 1, 1)),
						$mdgriffith$elm_ui$Element$width(
						A2(
							$mdgriffith$elm_ui$Element$maximum,
							150,
							A2($mdgriffith$elm_ui$Element$minimum, 150, $mdgriffith$elm_ui$Element$fill))),
						$mdgriffith$elm_ui$Element$clip
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0, 0, 0)),
								$mdgriffith$elm_ui$Element$Font$size(18)
							]),
						$mdgriffith$elm_ui$Element$text(tvshow.label)),
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
								$mdgriffith$elm_ui$Element$Font$size(18)
							]),
						$mdgriffith$elm_ui$Element$text('2020'))
					]))
			]));
};
var $author$project$Pages$Tvshows$Recent$view = function (model) {
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						$author$project$Components$VerticalNavTvshows$view(model.route),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$fillPortion(6)),
								A2($mdgriffith$elm_ui$Element$spacingXY, 5, 7),
								$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$background)
							]),
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, 'Recently Added TV shows', $elm$core$Maybe$Nothing, false, _List_Nil),
										A2(
										$mdgriffith$elm_ui$Element$wrappedRow,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
												$mdgriffith$elm_ui$Element$width(
												$mdgriffith$elm_ui$Element$fillPortion(6)),
												$mdgriffith$elm_ui$Element$Background$color(
												A3($mdgriffith$elm_ui$Element$rgb, 0.8, 0.8, 0.8)),
												A2($mdgriffith$elm_ui$Element$spacingXY, 5, 10)
											]),
										A2(
											$elm$core$List$map,
											function (tvshow) {
												return $author$project$Pages$Tvshows$Recent$constructTvshowItem(tvshow);
											},
											model.tvshow_list))
									])),
								A2(
								$mdgriffith$elm_ui$Element$column,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
									]),
								_List_fromArray(
									[
										A4($author$project$Components$SectionHeader$view, 'All TV shows', $elm$core$Maybe$Nothing, false, _List_Nil),
										A2(
										$mdgriffith$elm_ui$Element$wrappedRow,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
												$mdgriffith$elm_ui$Element$width(
												$mdgriffith$elm_ui$Element$fillPortion(6)),
												$mdgriffith$elm_ui$Element$Background$color(
												A3($mdgriffith$elm_ui$Element$rgb, 0.8, 0.8, 0.8)),
												A2($mdgriffith$elm_ui$Element$spacingXY, 5, 10)
											]),
										A2(
											$elm$core$List$map,
											function (tvshow) {
												return $author$project$Pages$Tvshows$Recent$constructTvshowItem(tvshow);
											},
											model.tvshow_list))
									]))
							]))
					]))
			]),
		title: 'Tvshows'
	};
};
var $author$project$Pages$Tvshows$Recent$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Tvshows$Recent$init, load: $author$project$Pages$Tvshows$Recent$load, save: $author$project$Pages$Tvshows$Recent$save, subscriptions: $author$project$Pages$Tvshows$Recent$subscriptions, update: $author$project$Pages$Tvshows$Recent$update, view: $author$project$Pages$Tvshows$Recent$view});
var $author$project$Pages$Videoplayer$Movieid_Int$checkMovieId = F2(
	function (firstId, movie) {
		return _Utils_eq(firstId, movie.movieid) ? true : false;
	});
var $author$project$Pages$Videoplayer$Movieid_Int$getMovie = F2(
	function (id, movielist) {
		return $elm$core$List$head(
			A2(
				$elm$core$List$filter,
				function (movie) {
					return A2($author$project$Pages$Videoplayer$Movieid_Int$checkMovieId, id, movie);
				},
				movielist));
	});
var $author$project$Pages$Videoplayer$Movieid_Int$GotMovie = function (a) {
	return {$: 'GotMovie', a: a};
};
var $elm$http$Http$BadStatus_ = F2(
	function (a, b) {
		return {$: 'BadStatus_', a: a, b: b};
	});
var $elm$http$Http$BadUrl_ = function (a) {
	return {$: 'BadUrl_', a: a};
};
var $elm$http$Http$GoodStatus_ = F2(
	function (a, b) {
		return {$: 'GoodStatus_', a: a, b: b};
	});
var $elm$http$Http$NetworkError_ = {$: 'NetworkError_'};
var $elm$http$Http$Receiving = function (a) {
	return {$: 'Receiving', a: a};
};
var $elm$http$Http$Sending = function (a) {
	return {$: 'Sending', a: a};
};
var $elm$http$Http$Timeout_ = {$: 'Timeout_'};
var $elm$core$Maybe$isJust = function (maybe) {
	if (maybe.$ === 'Just') {
		return true;
	} else {
		return false;
	}
};
var $elm$core$Platform$sendToSelf = _Platform_sendToSelf;
var $elm$http$Http$expectStringResponse = F2(
	function (toMsg, toResult) {
		return A3(
			_Http_expect,
			'',
			$elm$core$Basics$identity,
			A2($elm$core$Basics$composeR, toResult, toMsg));
	});
var $elm$core$Result$mapError = F2(
	function (f, result) {
		if (result.$ === 'Ok') {
			var v = result.a;
			return $elm$core$Result$Ok(v);
		} else {
			var e = result.a;
			return $elm$core$Result$Err(
				f(e));
		}
	});
var $elm$http$Http$BadBody = function (a) {
	return {$: 'BadBody', a: a};
};
var $elm$http$Http$BadStatus = function (a) {
	return {$: 'BadStatus', a: a};
};
var $elm$http$Http$BadUrl = function (a) {
	return {$: 'BadUrl', a: a};
};
var $elm$http$Http$NetworkError = {$: 'NetworkError'};
var $elm$http$Http$Timeout = {$: 'Timeout'};
var $elm$http$Http$resolve = F2(
	function (toResult, response) {
		switch (response.$) {
			case 'BadUrl_':
				var url = response.a;
				return $elm$core$Result$Err(
					$elm$http$Http$BadUrl(url));
			case 'Timeout_':
				return $elm$core$Result$Err($elm$http$Http$Timeout);
			case 'NetworkError_':
				return $elm$core$Result$Err($elm$http$Http$NetworkError);
			case 'BadStatus_':
				var metadata = response.a;
				return $elm$core$Result$Err(
					$elm$http$Http$BadStatus(metadata.statusCode));
			default:
				var body = response.b;
				return A2(
					$elm$core$Result$mapError,
					$elm$http$Http$BadBody,
					toResult(body));
		}
	});
var $elm$http$Http$expectJson = F2(
	function (toMsg, decoder) {
		return A2(
			$elm$http$Http$expectStringResponse,
			toMsg,
			$elm$http$Http$resolve(
				function (string) {
					return A2(
						$elm$core$Result$mapError,
						$elm$json$Json$Decode$errorToString,
						A2($elm$json$Json$Decode$decodeString, decoder, string));
				}));
	});
var $elm$http$Http$emptyBody = _Http_emptyBody;
var $elm$http$Http$Request = function (a) {
	return {$: 'Request', a: a};
};
var $elm$http$Http$State = F2(
	function (reqs, subs) {
		return {reqs: reqs, subs: subs};
	});
var $elm$http$Http$init = $elm$core$Task$succeed(
	A2($elm$http$Http$State, $elm$core$Dict$empty, _List_Nil));
var $elm$core$Process$kill = _Scheduler_kill;
var $elm$core$Process$spawn = _Scheduler_spawn;
var $elm$http$Http$updateReqs = F3(
	function (router, cmds, reqs) {
		updateReqs:
		while (true) {
			if (!cmds.b) {
				return $elm$core$Task$succeed(reqs);
			} else {
				var cmd = cmds.a;
				var otherCmds = cmds.b;
				if (cmd.$ === 'Cancel') {
					var tracker = cmd.a;
					var _v2 = A2($elm$core$Dict$get, tracker, reqs);
					if (_v2.$ === 'Nothing') {
						var $temp$router = router,
							$temp$cmds = otherCmds,
							$temp$reqs = reqs;
						router = $temp$router;
						cmds = $temp$cmds;
						reqs = $temp$reqs;
						continue updateReqs;
					} else {
						var pid = _v2.a;
						return A2(
							$elm$core$Task$andThen,
							function (_v3) {
								return A3(
									$elm$http$Http$updateReqs,
									router,
									otherCmds,
									A2($elm$core$Dict$remove, tracker, reqs));
							},
							$elm$core$Process$kill(pid));
					}
				} else {
					var req = cmd.a;
					return A2(
						$elm$core$Task$andThen,
						function (pid) {
							var _v4 = req.tracker;
							if (_v4.$ === 'Nothing') {
								return A3($elm$http$Http$updateReqs, router, otherCmds, reqs);
							} else {
								var tracker = _v4.a;
								return A3(
									$elm$http$Http$updateReqs,
									router,
									otherCmds,
									A3($elm$core$Dict$insert, tracker, pid, reqs));
							}
						},
						$elm$core$Process$spawn(
							A3(
								_Http_toTask,
								router,
								$elm$core$Platform$sendToApp(router),
								req)));
				}
			}
		}
	});
var $elm$http$Http$onEffects = F4(
	function (router, cmds, subs, state) {
		return A2(
			$elm$core$Task$andThen,
			function (reqs) {
				return $elm$core$Task$succeed(
					A2($elm$http$Http$State, reqs, subs));
			},
			A3($elm$http$Http$updateReqs, router, cmds, state.reqs));
	});
var $elm$http$Http$maybeSend = F4(
	function (router, desiredTracker, progress, _v0) {
		var actualTracker = _v0.a;
		var toMsg = _v0.b;
		return _Utils_eq(desiredTracker, actualTracker) ? $elm$core$Maybe$Just(
			A2(
				$elm$core$Platform$sendToApp,
				router,
				toMsg(progress))) : $elm$core$Maybe$Nothing;
	});
var $elm$http$Http$onSelfMsg = F3(
	function (router, _v0, state) {
		var tracker = _v0.a;
		var progress = _v0.b;
		return A2(
			$elm$core$Task$andThen,
			function (_v1) {
				return $elm$core$Task$succeed(state);
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$filterMap,
					A3($elm$http$Http$maybeSend, router, tracker, progress),
					state.subs)));
	});
var $elm$http$Http$Cancel = function (a) {
	return {$: 'Cancel', a: a};
};
var $elm$http$Http$cmdMap = F2(
	function (func, cmd) {
		if (cmd.$ === 'Cancel') {
			var tracker = cmd.a;
			return $elm$http$Http$Cancel(tracker);
		} else {
			var r = cmd.a;
			return $elm$http$Http$Request(
				{
					allowCookiesFromOtherDomains: r.allowCookiesFromOtherDomains,
					body: r.body,
					expect: A2(_Http_mapExpect, func, r.expect),
					headers: r.headers,
					method: r.method,
					timeout: r.timeout,
					tracker: r.tracker,
					url: r.url
				});
		}
	});
var $elm$http$Http$MySub = F2(
	function (a, b) {
		return {$: 'MySub', a: a, b: b};
	});
var $elm$http$Http$subMap = F2(
	function (func, _v0) {
		var tracker = _v0.a;
		var toMsg = _v0.b;
		return A2(
			$elm$http$Http$MySub,
			tracker,
			A2($elm$core$Basics$composeR, toMsg, func));
	});
_Platform_effectManagers['Http'] = _Platform_createManager($elm$http$Http$init, $elm$http$Http$onEffects, $elm$http$Http$onSelfMsg, $elm$http$Http$cmdMap, $elm$http$Http$subMap);
var $elm$http$Http$command = _Platform_leaf('Http');
var $elm$http$Http$subscription = _Platform_leaf('Http');
var $elm$http$Http$request = function (r) {
	return $elm$http$Http$command(
		$elm$http$Http$Request(
			{allowCookiesFromOtherDomains: false, body: r.body, expect: r.expect, headers: r.headers, method: r.method, timeout: r.timeout, tracker: r.tracker, url: r.url}));
};
var $elm$http$Http$get = function (r) {
	return $elm$http$Http$request(
		{body: $elm$http$Http$emptyBody, expect: r.expect, headers: _List_Nil, method: 'GET', timeout: $elm$core$Maybe$Nothing, tracker: $elm$core$Maybe$Nothing, url: r.url});
};
var $author$project$WSDecoder$Path = function (path) {
	return {path: path};
};
var $author$project$WSDecoder$prepareDownloadDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['result', 'details', 'path']),
		$elm$json$Json$Decode$string),
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$Path));
var $author$project$Pages$Videoplayer$Movieid_Int$postRequestMovie = function (path) {
	return $elm$http$Http$get(
		{
			expect: A2($elm$http$Http$expectJson, $author$project$Pages$Videoplayer$Movieid_Int$GotMovie, $author$project$WSDecoder$prepareDownloadDecoder),
			url: A3(
				$elm$url$Url$Builder$crossOrigin,
				'http://localhost:8080',
				_List_fromArray(
					['jsonrpc?request={"jsonrpc":"2.0","params":{"path":\"' + (path + '\"},"method":"Files.PrepareDownload","id":"1"}')]),
				_List_Nil)
		});
};
var $author$project$Pages$Videoplayer$Movieid_Int$init = F2(
	function (shared, _v0) {
		var params = _v0.params;
		var _v1 = A2($author$project$Pages$Videoplayer$Movieid_Int$getMovie, params.movieid, shared.movie_list);
		if (_v1.$ === 'Nothing') {
			return _Utils_Tuple2(
				{
					movie: A2($author$project$Pages$Videoplayer$Movieid_Int$getMovie, params.movieid, shared.movie_list),
					movie_list: shared.movie_list,
					movieid: params.movieid,
					prepareDownloadPath: shared.prepareDownloadPath
				},
				$elm$core$Platform$Cmd$none);
		} else {
			var mov = _v1.a;
			return _Utils_Tuple2(
				{
					movie: A2($author$project$Pages$Videoplayer$Movieid_Int$getMovie, params.movieid, shared.movie_list),
					movie_list: shared.movie_list,
					movieid: params.movieid,
					prepareDownloadPath: shared.prepareDownloadPath
				},
				$author$project$Pages$Videoplayer$Movieid_Int$postRequestMovie(mov.file));
		}
	});
var $author$project$Pages$Videoplayer$Movieid_Int$load = F2(
	function (shared, model) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{movie_list: shared.movie_list, prepareDownloadPath: shared.prepareDownloadPath}),
			$elm$core$Platform$Cmd$none);
	});
var $author$project$Pages$Videoplayer$Movieid_Int$save = F2(
	function (model, shared) {
		return _Utils_update(
			shared,
			{prepareDownloadPath: model.prepareDownloadPath});
	});
var $author$project$Pages$Videoplayer$Movieid_Int$subscriptions = function (model) {
	return $elm$core$Platform$Sub$none;
};
var $author$project$Pages$Videoplayer$Movieid_Int$update = F2(
	function (msg, model) {
		var result = msg.a;
		if (result.$ === 'Ok') {
			var pathObj = result.a;
			return _Utils_Tuple2(
				_Utils_update(
					model,
					{
						prepareDownloadPath: $elm$core$Maybe$Just(pathObj.path)
					}),
				$elm$core$Platform$Cmd$none);
		} else {
			return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
		}
	});
var $elm$html$Html$Attributes$attribute = $elm$virtual_dom$VirtualDom$attribute;
var $elm$html$Html$Attributes$poster = $elm$html$Html$Attributes$stringProperty('poster');
var $elm$html$Html$Attributes$preload = $elm$html$Html$Attributes$stringProperty('preload');
var $elm$html$Html$source = _VirtualDom_node('source');
var $elm$html$Html$video = _VirtualDom_node('video');
var $author$project$Components$Video$view = F2(
	function (attrs, _v0) {
		var poster = _v0.poster;
		var source = _v0.source;
		return A2(
			$mdgriffith$elm_ui$Element$el,
			attrs,
			$mdgriffith$elm_ui$Element$html(
				A2(
					$elm$html$Html$video,
					_List_fromArray(
						[
							A2($elm$html$Html$Attributes$attribute, 'controls', 'controls'),
							$elm$html$Html$Attributes$preload('none'),
							$elm$html$Html$Attributes$poster(poster)
						]),
					_List_fromArray(
						[
							A2(
							$elm$html$Html$source,
							_List_fromArray(
								[
									$elm$html$Html$Attributes$id('mp4'),
									$elm$html$Html$Attributes$src(source),
									$elm$html$Html$Attributes$type_('video/mp4')
								]),
							_List_Nil)
						]))));
	});
var $author$project$Pages$Videoplayer$Movieid_Int$view = function (model) {
	return {
		body: _List_fromArray(
			[
				function () {
				var _v0 = model.movie;
				if (_v0.$ === 'Nothing') {
					return $mdgriffith$elm_ui$Element$text('Erro fetching movie');
				} else {
					var movie = _v0.a;
					var _v1 = model.prepareDownloadPath;
					if (_v1.$ === 'Nothing') {
						return $mdgriffith$elm_ui$Element$text(movie.label);
					} else {
						var path = _v1.a;
						return A2(
							$author$project$Components$Video$view,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$Background$color(
									A3($mdgriffith$elm_ui$Element$rgb, 0, 0, 0))
								]),
							{
								poster: A3(
									$elm$url$Url$Builder$crossOrigin,
									'http://localhost:8080',
									_List_fromArray(
										[
											'image',
											$elm$url$Url$percentEncode(movie.thumbnail)
										]),
									_List_Nil),
								source: A3(
									$elm$url$Url$Builder$crossOrigin,
									'http://localhost:8080',
									_List_fromArray(
										[path]),
									_List_Nil)
							});
					}
				}
			}()
			]),
		title: 'Videoplayer.Movieid_Int'
	};
};
var $author$project$Pages$Videoplayer$Movieid_Int$page = $author$project$Spa$Page$application(
	{init: $author$project$Pages$Videoplayer$Movieid_Int$init, load: $author$project$Pages$Videoplayer$Movieid_Int$load, save: $author$project$Pages$Videoplayer$Movieid_Int$save, subscriptions: $author$project$Pages$Videoplayer$Movieid_Int$subscriptions, update: $author$project$Pages$Videoplayer$Movieid_Int$update, view: $author$project$Pages$Videoplayer$Movieid_Int$view});
var $elm$core$Tuple$mapBoth = F3(
	function (funcA, funcB, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			funcA(x),
			funcB(y));
	});
var $author$project$Spa$Url$toQueryDict = function (queryString) {
	var second = A2(
		$elm$core$Basics$composeR,
		$elm$core$List$drop(1),
		$elm$core$List$head);
	var toTuple = function (list) {
		return A2(
			$elm$core$Maybe$map,
			function (first) {
				return _Utils_Tuple2(
					first,
					A2(
						$elm$core$Maybe$withDefault,
						'',
						second(list)));
			},
			$elm$core$List$head(list));
	};
	var decode = A2(
		$elm$core$Basics$composeR,
		$elm$url$Url$percentDecode,
		$elm$core$Maybe$withDefault(''));
	return $elm$core$Dict$fromList(
		A2(
			$elm$core$List$map,
			A2($elm$core$Tuple$mapBoth, decode, decode),
			A2(
				$elm$core$List$filterMap,
				toTuple,
				A2(
					$elm$core$List$map,
					$elm$core$String$split('='),
					A2($elm$core$String$split, '&', queryString)))));
};
var $author$project$Spa$Url$create = F3(
	function (params, key, url) {
		return {
			key: key,
			params: params,
			query: A2(
				$elm$core$Maybe$withDefault,
				$elm$core$Dict$empty,
				A2($elm$core$Maybe$map, $author$project$Spa$Url$toQueryDict, url.query)),
			rawUrl: url,
			route: A2(
				$elm$core$Maybe$withDefault,
				$author$project$Spa$Generated$Route$NotFound,
				$author$project$Spa$Generated$Route$fromUrl(url))
		};
	});
var $mdgriffith$elm_ui$Element$map = $mdgriffith$elm_ui$Internal$Model$map;
var $author$project$Spa$Document$map = F2(
	function (fn, doc) {
		return {
			body: A2(
				$elm$core$List$map,
				$mdgriffith$elm_ui$Element$map(fn),
				doc.body),
			title: doc.title
		};
	});
var $author$project$Spa$Generated$Pages$upgrade = F3(
	function (toModel, toMsg, page) {
		var update_ = F2(
			function (msg, model) {
				return A3(
					$elm$core$Tuple$mapBoth,
					toModel,
					$elm$core$Platform$Cmd$map(toMsg),
					A2(page.update, msg, model));
			});
		var load_ = F2(
			function (model, shared) {
				return A3(
					$elm$core$Tuple$mapBoth,
					toModel,
					$elm$core$Platform$Cmd$map(toMsg),
					A2(page.load, shared, model));
			});
		var init_ = F2(
			function (params, shared) {
				return A3(
					$elm$core$Tuple$mapBoth,
					toModel,
					$elm$core$Platform$Cmd$map(toMsg),
					A2(
						page.init,
						shared,
						A3($author$project$Spa$Url$create, params, shared.key, shared.url)));
			});
		var bundle_ = function (model) {
			return {
				load: load_(model),
				save: page.save(model),
				subscriptions: A2(
					$elm$core$Platform$Sub$map,
					toMsg,
					page.subscriptions(model)),
				view: A2(
					$author$project$Spa$Document$map,
					toMsg,
					page.view(model))
			};
		};
		return {bundle: bundle_, init: init_, update: update_};
	});
var $author$project$Spa$Generated$Pages$pages = {
	addons: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Addons__Model, $author$project$Spa$Generated$Pages$Addons__Msg, $author$project$Pages$Addons$page),
	browser: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Browser__Model, $author$project$Spa$Generated$Pages$Browser__Msg, $author$project$Pages$Browser$page),
	browser__source_string: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Browser__Source_String__Model, $author$project$Spa$Generated$Pages$Browser__Source_String__Msg, $author$project$Pages$Browser$Source_String$page),
	help: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Help__Model, $author$project$Spa$Generated$Pages$Help__Msg, $author$project$Pages$Help$page),
	lab: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Lab__Model, $author$project$Spa$Generated$Pages$Lab__Msg, $author$project$Pages$Lab$page),
	movies: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Movies__Model, $author$project$Spa$Generated$Pages$Movies__Msg, $author$project$Pages$Movies$page),
	movies__recent: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Movies__Recent__Model, $author$project$Spa$Generated$Pages$Movies__Recent__Msg, $author$project$Pages$Movies$Recent$page),
	music: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Music__Model, $author$project$Spa$Generated$Pages$Music__Msg, $author$project$Pages$Music$page),
	music__album__albumid_int: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Music__Album__Albumid_Int__Model, $author$project$Spa$Generated$Pages$Music__Album__Albumid_Int__Msg, $author$project$Pages$Music$Album$Albumid_Int$page),
	music__albums: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Music__Albums__Model, $author$project$Spa$Generated$Pages$Music__Albums__Msg, $author$project$Pages$Music$Albums$page),
	music__artist__artistid_int: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Music__Artist__Artistid_Int__Model, $author$project$Spa$Generated$Pages$Music__Artist__Artistid_Int__Msg, $author$project$Pages$Music$Artist$Artistid_Int$page),
	music__artists: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Music__Artists__Model, $author$project$Spa$Generated$Pages$Music__Artists__Msg, $author$project$Pages$Music$Artists$page),
	music__genre__genre_string: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Music__Genre__Genre_String__Model, $author$project$Spa$Generated$Pages$Music__Genre__Genre_String__Msg, $author$project$Pages$Music$Genre$Genre_String$page),
	music__genres: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Music__Genres__Model, $author$project$Spa$Generated$Pages$Music__Genres__Msg, $author$project$Pages$Music$Genres$page),
	music__top__top: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Music__Top__Top__Model, $author$project$Spa$Generated$Pages$Music__Top__Top__Msg, $author$project$Pages$Music$Top$Top$page),
	music__videos: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Music__Videos__Model, $author$project$Spa$Generated$Pages$Music__Videos__Msg, $author$project$Pages$Music$Videos$page),
	notFound: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$NotFound__Model, $author$project$Spa$Generated$Pages$NotFound__Msg, $author$project$Pages$NotFound$page),
	playlists: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Playlists__Model, $author$project$Spa$Generated$Pages$Playlists__Msg, $author$project$Pages$Playlists$page),
	playlists__name_string: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Playlists__Name_String__Model, $author$project$Spa$Generated$Pages$Playlists__Name_String__Msg, $author$project$Pages$Playlists$Name_String$page),
	settings__addons: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Addons__Model, $author$project$Spa$Generated$Pages$Settings__Addons__Msg, $author$project$Pages$Settings$Addons$page),
	settings__kodi__games: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Kodi__Games__Model, $author$project$Spa$Generated$Pages$Settings__Kodi__Games__Msg, $author$project$Pages$Settings$Kodi$Games$page),
	settings__kodi__interface: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Kodi__Interface__Model, $author$project$Spa$Generated$Pages$Settings__Kodi__Interface__Msg, $author$project$Pages$Settings$Kodi$Interface$page),
	settings__kodi__media: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Kodi__Media__Model, $author$project$Spa$Generated$Pages$Settings__Kodi__Media__Msg, $author$project$Pages$Settings$Kodi$Media$page),
	settings__kodi__player: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Kodi__Player__Model, $author$project$Spa$Generated$Pages$Settings__Kodi__Player__Msg, $author$project$Pages$Settings$Kodi$Player$page),
	settings__kodi__pvr: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Kodi__Pvr__Model, $author$project$Spa$Generated$Pages$Settings__Kodi__Pvr__Msg, $author$project$Pages$Settings$Kodi$Pvr$page),
	settings__kodi__services: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Kodi__Services__Model, $author$project$Spa$Generated$Pages$Settings__Kodi__Services__Msg, $author$project$Pages$Settings$Kodi$Services$page),
	settings__kodi__system: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Kodi__System__Model, $author$project$Spa$Generated$Pages$Settings__Kodi__System__Msg, $author$project$Pages$Settings$Kodi$System$page),
	settings__nav: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Nav__Model, $author$project$Spa$Generated$Pages$Settings__Nav__Msg, $author$project$Pages$Settings$Nav$page),
	settings__search: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Search__Model, $author$project$Spa$Generated$Pages$Settings__Search__Msg, $author$project$Pages$Settings$Search$page),
	settings__web: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Settings__Web__Model, $author$project$Spa$Generated$Pages$Settings__Web__Msg, $author$project$Pages$Settings$Web$page),
	thumbsup: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Thumbsup__Model, $author$project$Spa$Generated$Pages$Thumbsup__Msg, $author$project$Pages$Thumbsup$page),
	top: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Top__Model, $author$project$Spa$Generated$Pages$Top__Msg, $author$project$Pages$Top$page),
	tvshows: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Tvshows__Model, $author$project$Spa$Generated$Pages$Tvshows__Msg, $author$project$Pages$Tvshows$page),
	tvshows__recent: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Tvshows__Recent__Model, $author$project$Spa$Generated$Pages$Tvshows__Recent__Msg, $author$project$Pages$Tvshows$Recent$page),
	videoplayer__movieid_int: A3($author$project$Spa$Generated$Pages$upgrade, $author$project$Spa$Generated$Pages$Videoplayer__Movieid_Int__Model, $author$project$Spa$Generated$Pages$Videoplayer__Movieid_Int__Msg, $author$project$Pages$Videoplayer$Movieid_Int$page)
};
var $author$project$Spa$Generated$Pages$init = function (route) {
	switch (route.$) {
		case 'Top':
			return $author$project$Spa$Generated$Pages$pages.top.init(_Utils_Tuple0);
		case 'Addons':
			return $author$project$Spa$Generated$Pages$pages.addons.init(_Utils_Tuple0);
		case 'Browser':
			return $author$project$Spa$Generated$Pages$pages.browser.init(_Utils_Tuple0);
		case 'Help':
			return $author$project$Spa$Generated$Pages$pages.help.init(_Utils_Tuple0);
		case 'Lab':
			return $author$project$Spa$Generated$Pages$pages.lab.init(_Utils_Tuple0);
		case 'Movies':
			return $author$project$Spa$Generated$Pages$pages.movies.init(_Utils_Tuple0);
		case 'Music':
			return $author$project$Spa$Generated$Pages$pages.music.init(_Utils_Tuple0);
		case 'NotFound':
			return $author$project$Spa$Generated$Pages$pages.notFound.init(_Utils_Tuple0);
		case 'Playlists':
			return $author$project$Spa$Generated$Pages$pages.playlists.init(_Utils_Tuple0);
		case 'Thumbsup':
			return $author$project$Spa$Generated$Pages$pages.thumbsup.init(_Utils_Tuple0);
		case 'Tvshows':
			return $author$project$Spa$Generated$Pages$pages.tvshows.init(_Utils_Tuple0);
		case 'Movies__Recent':
			return $author$project$Spa$Generated$Pages$pages.movies__recent.init(_Utils_Tuple0);
		case 'Music__Albums':
			return $author$project$Spa$Generated$Pages$pages.music__albums.init(_Utils_Tuple0);
		case 'Music__Artists':
			return $author$project$Spa$Generated$Pages$pages.music__artists.init(_Utils_Tuple0);
		case 'Music__Genres':
			return $author$project$Spa$Generated$Pages$pages.music__genres.init(_Utils_Tuple0);
		case 'Music__Videos':
			return $author$project$Spa$Generated$Pages$pages.music__videos.init(_Utils_Tuple0);
		case 'Settings__Addons':
			return $author$project$Spa$Generated$Pages$pages.settings__addons.init(_Utils_Tuple0);
		case 'Settings__Nav':
			return $author$project$Spa$Generated$Pages$pages.settings__nav.init(_Utils_Tuple0);
		case 'Settings__Search':
			return $author$project$Spa$Generated$Pages$pages.settings__search.init(_Utils_Tuple0);
		case 'Settings__Web':
			return $author$project$Spa$Generated$Pages$pages.settings__web.init(_Utils_Tuple0);
		case 'Tvshows__Recent':
			return $author$project$Spa$Generated$Pages$pages.tvshows__recent.init(_Utils_Tuple0);
		case 'Browser__Source_String':
			var params = route.a;
			return $author$project$Spa$Generated$Pages$pages.browser__source_string.init(params);
		case 'Playlists__Name_String':
			var params = route.a;
			return $author$project$Spa$Generated$Pages$pages.playlists__name_string.init(params);
		case 'Videoplayer__Movieid_Int':
			var params = route.a;
			return $author$project$Spa$Generated$Pages$pages.videoplayer__movieid_int.init(params);
		case 'Music__Top__Top':
			return $author$project$Spa$Generated$Pages$pages.music__top__top.init(_Utils_Tuple0);
		case 'Settings__Kodi__Games':
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__games.init(_Utils_Tuple0);
		case 'Settings__Kodi__Interface':
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__interface.init(_Utils_Tuple0);
		case 'Settings__Kodi__Media':
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__media.init(_Utils_Tuple0);
		case 'Settings__Kodi__Player':
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__player.init(_Utils_Tuple0);
		case 'Settings__Kodi__Pvr':
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__pvr.init(_Utils_Tuple0);
		case 'Settings__Kodi__Services':
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__services.init(_Utils_Tuple0);
		case 'Settings__Kodi__System':
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__system.init(_Utils_Tuple0);
		case 'Music__Album__Albumid_Int':
			var params = route.a;
			return $author$project$Spa$Generated$Pages$pages.music__album__albumid_int.init(params);
		case 'Music__Artist__Artistid_Int':
			var params = route.a;
			return $author$project$Spa$Generated$Pages$pages.music__artist__artistid_int.init(params);
		default:
			var params = route.a;
			return $author$project$Spa$Generated$Pages$pages.music__genre__genre_string.init(params);
	}
};
var $author$project$Main$init = F3(
	function (flags, url, key) {
		var _v0 = A3($author$project$Shared$init, flags, url, key);
		var shared = _v0.a;
		var sharedCmd = _v0.b;
		var _v1 = A2(
			$author$project$Spa$Generated$Pages$init,
			$author$project$Main$fromUrl(url),
			shared);
		var page = _v1.a;
		var pageCmd = _v1.b;
		return _Utils_Tuple2(
			A2($author$project$Main$Model, shared, page),
			$elm$core$Platform$Cmd$batch(
				_List_fromArray(
					[
						A2($elm$core$Platform$Cmd$map, $author$project$Main$Shared, sharedCmd),
						A2($elm$core$Platform$Cmd$map, $author$project$Main$Pages, pageCmd)
					])));
	});
var $elm$json$Json$Decode$null = _Json_decodeNull;
var $elm$json$Json$Decode$oneOf = _Json_oneOf;
var $author$project$Main$GotNewSize = F2(
	function (a, b) {
		return {$: 'GotNewSize', a: a, b: b};
	});
var $elm$browser$Browser$Events$Window = {$: 'Window'};
var $elm$browser$Browser$Events$MySub = F3(
	function (a, b, c) {
		return {$: 'MySub', a: a, b: b, c: c};
	});
var $elm$browser$Browser$Events$State = F2(
	function (subs, pids) {
		return {pids: pids, subs: subs};
	});
var $elm$browser$Browser$Events$init = $elm$core$Task$succeed(
	A2($elm$browser$Browser$Events$State, _List_Nil, $elm$core$Dict$empty));
var $elm$browser$Browser$Events$nodeToKey = function (node) {
	if (node.$ === 'Document') {
		return 'd_';
	} else {
		return 'w_';
	}
};
var $elm$browser$Browser$Events$addKey = function (sub) {
	var node = sub.a;
	var name = sub.b;
	return _Utils_Tuple2(
		_Utils_ap(
			$elm$browser$Browser$Events$nodeToKey(node),
			name),
		sub);
};
var $elm$browser$Browser$Events$Event = F2(
	function (key, event) {
		return {event: event, key: key};
	});
var $elm$browser$Browser$Events$spawn = F3(
	function (router, key, _v0) {
		var node = _v0.a;
		var name = _v0.b;
		var actualNode = function () {
			if (node.$ === 'Document') {
				return _Browser_doc;
			} else {
				return _Browser_window;
			}
		}();
		return A2(
			$elm$core$Task$map,
			function (value) {
				return _Utils_Tuple2(key, value);
			},
			A3(
				_Browser_on,
				actualNode,
				name,
				function (event) {
					return A2(
						$elm$core$Platform$sendToSelf,
						router,
						A2($elm$browser$Browser$Events$Event, key, event));
				}));
	});
var $elm$core$Dict$union = F2(
	function (t1, t2) {
		return A3($elm$core$Dict$foldl, $elm$core$Dict$insert, t2, t1);
	});
var $elm$browser$Browser$Events$onEffects = F3(
	function (router, subs, state) {
		var stepRight = F3(
			function (key, sub, _v6) {
				var deads = _v6.a;
				var lives = _v6.b;
				var news = _v6.c;
				return _Utils_Tuple3(
					deads,
					lives,
					A2(
						$elm$core$List$cons,
						A3($elm$browser$Browser$Events$spawn, router, key, sub),
						news));
			});
		var stepLeft = F3(
			function (_v4, pid, _v5) {
				var deads = _v5.a;
				var lives = _v5.b;
				var news = _v5.c;
				return _Utils_Tuple3(
					A2($elm$core$List$cons, pid, deads),
					lives,
					news);
			});
		var stepBoth = F4(
			function (key, pid, _v2, _v3) {
				var deads = _v3.a;
				var lives = _v3.b;
				var news = _v3.c;
				return _Utils_Tuple3(
					deads,
					A3($elm$core$Dict$insert, key, pid, lives),
					news);
			});
		var newSubs = A2($elm$core$List$map, $elm$browser$Browser$Events$addKey, subs);
		var _v0 = A6(
			$elm$core$Dict$merge,
			stepLeft,
			stepBoth,
			stepRight,
			state.pids,
			$elm$core$Dict$fromList(newSubs),
			_Utils_Tuple3(_List_Nil, $elm$core$Dict$empty, _List_Nil));
		var deadPids = _v0.a;
		var livePids = _v0.b;
		var makeNewPids = _v0.c;
		return A2(
			$elm$core$Task$andThen,
			function (pids) {
				return $elm$core$Task$succeed(
					A2(
						$elm$browser$Browser$Events$State,
						newSubs,
						A2(
							$elm$core$Dict$union,
							livePids,
							$elm$core$Dict$fromList(pids))));
			},
			A2(
				$elm$core$Task$andThen,
				function (_v1) {
					return $elm$core$Task$sequence(makeNewPids);
				},
				$elm$core$Task$sequence(
					A2($elm$core$List$map, $elm$core$Process$kill, deadPids))));
	});
var $elm$browser$Browser$Events$onSelfMsg = F3(
	function (router, _v0, state) {
		var key = _v0.key;
		var event = _v0.event;
		var toMessage = function (_v2) {
			var subKey = _v2.a;
			var _v3 = _v2.b;
			var node = _v3.a;
			var name = _v3.b;
			var decoder = _v3.c;
			return _Utils_eq(subKey, key) ? A2(_Browser_decodeEvent, decoder, event) : $elm$core$Maybe$Nothing;
		};
		var messages = A2($elm$core$List$filterMap, toMessage, state.subs);
		return A2(
			$elm$core$Task$andThen,
			function (_v1) {
				return $elm$core$Task$succeed(state);
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Platform$sendToApp(router),
					messages)));
	});
var $elm$browser$Browser$Events$subMap = F2(
	function (func, _v0) {
		var node = _v0.a;
		var name = _v0.b;
		var decoder = _v0.c;
		return A3(
			$elm$browser$Browser$Events$MySub,
			node,
			name,
			A2($elm$json$Json$Decode$map, func, decoder));
	});
_Platform_effectManagers['Browser.Events'] = _Platform_createManager($elm$browser$Browser$Events$init, $elm$browser$Browser$Events$onEffects, $elm$browser$Browser$Events$onSelfMsg, 0, $elm$browser$Browser$Events$subMap);
var $elm$browser$Browser$Events$subscription = _Platform_leaf('Browser.Events');
var $elm$browser$Browser$Events$on = F3(
	function (node, name, decoder) {
		return $elm$browser$Browser$Events$subscription(
			A3($elm$browser$Browser$Events$MySub, node, name, decoder));
	});
var $elm$browser$Browser$Events$onResize = function (func) {
	return A3(
		$elm$browser$Browser$Events$on,
		$elm$browser$Browser$Events$Window,
		'resize',
		A2(
			$elm$json$Json$Decode$field,
			'target',
			A3(
				$elm$json$Json$Decode$map2,
				func,
				A2($elm$json$Json$Decode$field, 'innerWidth', $elm$json$Json$Decode$int),
				A2($elm$json$Json$Decode$field, 'innerHeight', $elm$json$Json$Decode$int))));
};
var $author$project$Shared$QueryPlayers = function (a) {
	return {$: 'QueryPlayers', a: a};
};
var $author$project$Shared$connection = _Platform_incomingPort('connection', $elm$json$Json$Decode$string);
var $author$project$Shared$ReceiveParamsResponse = function (a) {
	return {$: 'ReceiveParamsResponse', a: a};
};
var $author$project$Shared$ReceiveResultResponse = function (a) {
	return {$: 'ReceiveResultResponse', a: a};
};
var $author$project$Shared$Recv = function (a) {
	return {$: 'Recv', a: a};
};
var $author$project$WSDecoder$ParamsResponse = F2(
	function (item, player) {
		return {item: item, player: player};
	});
var $author$project$WSDecoder$Item = F2(
	function (id, itype) {
		return {id: id, itype: itype};
	});
var $author$project$WSDecoder$itemDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'type',
	$elm$json$Json$Decode$string,
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'id',
		$elm$json$Json$Decode$int,
		$elm$json$Json$Decode$succeed($author$project$WSDecoder$Item)));
var $author$project$WSDecoder$PlayerA = F2(
	function (a, b) {
		return {$: 'PlayerA', a: a, b: b};
	});
var $author$project$WSDecoder$playerSpdDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'speed',
	$elm$json$Json$Decode$int,
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'playerid',
		$elm$json$Json$Decode$int,
		$elm$json$Json$Decode$succeed($author$project$WSDecoder$PlayerA)));
var $author$project$WSDecoder$PlayerB = F3(
	function (a, b, c) {
		return {$: 'PlayerB', a: a, b: b, c: c};
	});
var $author$project$WSDecoder$fromResult = function (result) {
	if (result.$ === 'Ok') {
		var a = result.a;
		return $elm$json$Json$Decode$succeed(a);
	} else {
		var errorMessage = result.a;
		return $elm$json$Json$Decode$fail(errorMessage);
	}
};
var $author$project$WSDecoder$Audio = {$: 'Audio'};
var $author$project$WSDecoder$Video = {$: 'Video'};
var $author$project$WSDecoder$parsePType = function (string) {
	switch (string) {
		case 'audio':
			return $elm$core$Result$Ok($author$project$WSDecoder$Audio);
		case 'video':
			return $elm$core$Result$Ok($author$project$WSDecoder$Video);
		default:
			return $elm$core$Result$Err('Invalid direction: ' + string);
	}
};
var $author$project$WSDecoder$pTypeDecoder = A2(
	$elm$json$Json$Decode$andThen,
	A2($elm$core$Basics$composeL, $author$project$WSDecoder$fromResult, $author$project$WSDecoder$parsePType),
	$elm$json$Json$Decode$string);
var $author$project$WSDecoder$External = {$: 'External'};
var $author$project$WSDecoder$Internal = {$: 'Internal'};
var $author$project$WSDecoder$parsePlayerType = function (string) {
	switch (string) {
		case 'internal':
			return $elm$core$Result$Ok($author$project$WSDecoder$Internal);
		case 'external':
			return $elm$core$Result$Ok($author$project$WSDecoder$External);
		default:
			return $elm$core$Result$Err('Invalid direction: ' + string);
	}
};
var $author$project$WSDecoder$playerTypeDecoder = A2(
	$elm$json$Json$Decode$andThen,
	A2($elm$core$Basics$composeL, $author$project$WSDecoder$fromResult, $author$project$WSDecoder$parsePlayerType),
	$elm$json$Json$Decode$string);
var $author$project$WSDecoder$playerwoSpdDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'type',
	$author$project$WSDecoder$pTypeDecoder,
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'playertype',
		$author$project$WSDecoder$playerTypeDecoder,
		A3(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
			'playerid',
			$elm$json$Json$Decode$int,
			$elm$json$Json$Decode$succeed($author$project$WSDecoder$PlayerB))));
var $author$project$WSDecoder$playerDecoder = $elm$json$Json$Decode$oneOf(
	_List_fromArray(
		[$author$project$WSDecoder$playerSpdDecoder, $author$project$WSDecoder$playerwoSpdDecoder]));
var $author$project$WSDecoder$paramsResponseDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['params', 'data', 'player']),
		$author$project$WSDecoder$playerDecoder),
	A2(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
		A2(
			$elm$json$Json$Decode$at,
			_List_fromArray(
				['params', 'data', 'item']),
			$author$project$WSDecoder$itemDecoder),
		$elm$json$Json$Decode$succeed($author$project$WSDecoder$ParamsResponse)));
var $author$project$WSDecoder$ResultC = function (a) {
	return {$: 'ResultC', a: a};
};
var $author$project$WSDecoder$ItemDetails = F4(
	function (title, artist, duration, thumbnail) {
		return {artist: artist, duration: duration, thumbnail: thumbnail, title: title};
	});
var $author$project$WSDecoder$itemDetailDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['item', 'thumbnail']),
		$elm$json$Json$Decode$string),
	A2(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
		A2(
			$elm$json$Json$Decode$at,
			_List_fromArray(
				['item', 'duration']),
			$elm$json$Json$Decode$int),
		A2(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
			A2(
				$elm$json$Json$Decode$at,
				_List_fromArray(
					['item', 'artist']),
				$elm$json$Json$Decode$list($elm$json$Json$Decode$string)),
			A2(
				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
				A2(
					$elm$json$Json$Decode$at,
					_List_fromArray(
						['item', 'title']),
					$elm$json$Json$Decode$string),
				$elm$json$Json$Decode$succeed($author$project$WSDecoder$ItemDetails)))));
var $author$project$WSDecoder$detailDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'result',
	$author$project$WSDecoder$itemDetailDecoder,
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultC));
var $author$project$WSDecoder$ResultB = function (a) {
	return {$: 'ResultB', a: a};
};
var $author$project$WSDecoder$listDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'result',
	$elm$json$Json$Decode$list($author$project$WSDecoder$playerDecoder),
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultB));
var $author$project$WSDecoder$ResultF = function (a) {
	return {$: 'ResultF', a: a};
};
var $author$project$WSDecoder$AlbumObj = F7(
	function (label, albumid, artist, thumbnail, genre, playcount, dateadded) {
		return {albumid: albumid, artist: artist, dateadded: dateadded, genre: genre, label: label, playcount: playcount, thumbnail: thumbnail};
	});
var $author$project$WSDecoder$albumDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'dateadded',
	$elm$json$Json$Decode$string,
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'playcount',
		$elm$json$Json$Decode$int,
		A3(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
			'genre',
			$elm$json$Json$Decode$list($elm$json$Json$Decode$string),
			A3(
				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
				'thumbnail',
				$elm$json$Json$Decode$string,
				A3(
					$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
					'artist',
					$elm$json$Json$Decode$list($elm$json$Json$Decode$string),
					A3(
						$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
						'albumid',
						$elm$json$Json$Decode$int,
						A3(
							$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
							'label',
							$elm$json$Json$Decode$string,
							$elm$json$Json$Decode$succeed($author$project$WSDecoder$AlbumObj))))))));
var $author$project$WSDecoder$albumQueryDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['result', 'albums']),
		$elm$json$Json$Decode$list($author$project$WSDecoder$albumDecoder)),
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultF));
var $author$project$WSDecoder$ResultE = function (a) {
	return {$: 'ResultE', a: a};
};
var $author$project$WSDecoder$ArtistObj = F4(
	function (label, artistid, thumbnail, genre) {
		return {artistid: artistid, genre: genre, label: label, thumbnail: thumbnail};
	});
var $author$project$WSDecoder$artistDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'genre',
	$elm$json$Json$Decode$list($elm$json$Json$Decode$string),
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'thumbnail',
		$elm$json$Json$Decode$string,
		A3(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
			'artistid',
			$elm$json$Json$Decode$int,
			A3(
				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
				'label',
				$elm$json$Json$Decode$string,
				$elm$json$Json$Decode$succeed($author$project$WSDecoder$ArtistObj)))));
var $author$project$WSDecoder$artistQueryDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['result', 'artists']),
		$elm$json$Json$Decode$list($author$project$WSDecoder$artistDecoder)),
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultE));
var $author$project$WSDecoder$ResultK = function (a) {
	return {$: 'ResultK', a: a};
};
var $author$project$WSDecoder$FileObj = F3(
	function (label, file, filetype) {
		return {file: file, filetype: filetype, label: label};
	});
var $author$project$WSDecoder$Directory = {$: 'Directory'};
var $author$project$WSDecoder$File = {$: 'File'};
var $author$project$WSDecoder$parseFileType = function (string) {
	switch (string) {
		case 'directory':
			return $elm$core$Result$Ok($author$project$WSDecoder$Directory);
		case 'file':
			return $elm$core$Result$Ok($author$project$WSDecoder$File);
		default:
			return $elm$core$Result$Err('Invalid filetype: ' + string);
	}
};
var $author$project$WSDecoder$fileTypeDecoder = A2(
	$elm$json$Json$Decode$andThen,
	A2($elm$core$Basics$composeL, $author$project$WSDecoder$fromResult, $author$project$WSDecoder$parseFileType),
	$elm$json$Json$Decode$string);
var $author$project$WSDecoder$fileDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'filetype',
	$author$project$WSDecoder$fileTypeDecoder,
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'file',
		$elm$json$Json$Decode$string,
		A3(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
			'label',
			$elm$json$Json$Decode$string,
			$elm$json$Json$Decode$succeed($author$project$WSDecoder$FileObj))));
var $author$project$WSDecoder$fileQueryDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['result', 'files']),
		$elm$json$Json$Decode$list($author$project$WSDecoder$fileDecoder)),
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultK));
var $author$project$WSDecoder$ResultG = function (a) {
	return {$: 'ResultG', a: a};
};
var $author$project$WSDecoder$MovieObj = F4(
	function (label, movieid, thumbnail, file) {
		return {file: file, label: label, movieid: movieid, thumbnail: thumbnail};
	});
var $author$project$WSDecoder$movieDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'file',
	$elm$json$Json$Decode$string,
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'thumbnail',
		$elm$json$Json$Decode$string,
		A3(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
			'movieid',
			$elm$json$Json$Decode$int,
			A3(
				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
				'label',
				$elm$json$Json$Decode$string,
				$elm$json$Json$Decode$succeed($author$project$WSDecoder$MovieObj)))));
var $author$project$WSDecoder$movieQueryDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['result', 'movies']),
		$elm$json$Json$Decode$list($author$project$WSDecoder$movieDecoder)),
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultG));
var $author$project$WSDecoder$ResultH = F2(
	function (a, b) {
		return {$: 'ResultH', a: a, b: b};
	});
var $author$project$WSDecoder$percentDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['result', 'speed']),
		$elm$json$Json$Decode$int),
	A2(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
		A2(
			$elm$json$Json$Decode$at,
			_List_fromArray(
				['result', 'percentage']),
			$elm$json$Json$Decode$float),
		$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultH)));
var $author$project$WSDecoder$ResultD = function (a) {
	return {$: 'ResultD', a: a};
};
var $author$project$WSDecoder$SongObj = F6(
	function (label, artist, duration, songid, albumid, genre) {
		return {albumid: albumid, artist: artist, duration: duration, genre: genre, label: label, songid: songid};
	});
var $author$project$WSDecoder$songDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'genre',
	$elm$json$Json$Decode$list($elm$json$Json$Decode$string),
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'albumid',
		$elm$json$Json$Decode$int,
		A3(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
			'songid',
			$elm$json$Json$Decode$int,
			A3(
				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
				'duration',
				$elm$json$Json$Decode$int,
				A3(
					$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
					'artist',
					$elm$json$Json$Decode$list($elm$json$Json$Decode$string),
					A3(
						$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
						'label',
						$elm$json$Json$Decode$string,
						$elm$json$Json$Decode$succeed($author$project$WSDecoder$SongObj)))))));
var $author$project$WSDecoder$songQueryDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['result', 'songs']),
		$elm$json$Json$Decode$list($author$project$WSDecoder$songDecoder)),
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultD));
var $author$project$WSDecoder$ResultI = function (a) {
	return {$: 'ResultI', a: a};
};
var $author$project$WSDecoder$SourceObj = F2(
	function (label, file) {
		return {file: file, label: label};
	});
var $author$project$WSDecoder$sourceDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'file',
	$elm$json$Json$Decode$string,
	A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
		'label',
		$elm$json$Json$Decode$string,
		$elm$json$Json$Decode$succeed($author$project$WSDecoder$SourceObj)));
var $author$project$WSDecoder$sourceQueryDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['result', 'sources']),
		$elm$json$Json$Decode$list($author$project$WSDecoder$sourceDecoder)),
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultI));
var $author$project$WSDecoder$ResultJ = F2(
	function (a, b) {
		return {$: 'ResultJ', a: a, b: b};
	});
var $elm$json$Json$Decode$bool = _Json_decodeBool;
var $author$project$WSDecoder$volumeDecoder = A2(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
	A2(
		$elm$json$Json$Decode$at,
		_List_fromArray(
			['result', 'volume']),
		$elm$json$Json$Decode$float),
	A2(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
		A2(
			$elm$json$Json$Decode$at,
			_List_fromArray(
				['result', 'muted']),
			$elm$json$Json$Decode$bool),
		$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultJ)));
var $author$project$WSDecoder$queryDecoder = $elm$json$Json$Decode$oneOf(
	_List_fromArray(
		[$author$project$WSDecoder$percentDecoder, $author$project$WSDecoder$songQueryDecoder, $author$project$WSDecoder$artistQueryDecoder, $author$project$WSDecoder$albumQueryDecoder, $author$project$WSDecoder$movieQueryDecoder, $author$project$WSDecoder$sourceQueryDecoder, $author$project$WSDecoder$volumeDecoder, $author$project$WSDecoder$fileQueryDecoder]));
var $author$project$WSDecoder$ResultA = function (a) {
	return {$: 'ResultA', a: a};
};
var $author$project$WSDecoder$stringDecoder = A3(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
	'result',
	$elm$json$Json$Decode$string,
	$elm$json$Json$Decode$succeed($author$project$WSDecoder$ResultA));
var $author$project$WSDecoder$resultResponseDecoder = $elm$json$Json$Decode$oneOf(
	_List_fromArray(
		[$author$project$WSDecoder$stringDecoder, $author$project$WSDecoder$listDecoder, $author$project$WSDecoder$detailDecoder, $author$project$WSDecoder$queryDecoder]));
var $author$project$Shared$decodeWS = function (message) {
	var _v0 = A2($elm$json$Json$Decode$decodeString, $author$project$WSDecoder$paramsResponseDecoder, message);
	if (_v0.$ === 'Ok') {
		var paramsMessage = _v0.a;
		return $author$project$Shared$ReceiveParamsResponse(paramsMessage);
	} else {
		var _v1 = A2($elm$json$Json$Decode$decodeString, $author$project$WSDecoder$resultResponseDecoder, message);
		if (_v1.$ === 'Ok') {
			var resultMessage = _v1.a;
			return $author$project$Shared$ReceiveResultResponse(resultMessage);
		} else {
			return $author$project$Shared$Recv(message);
		}
	}
};
var $elm$time$Time$Every = F2(
	function (a, b) {
		return {$: 'Every', a: a, b: b};
	});
var $elm$time$Time$State = F2(
	function (taggers, processes) {
		return {processes: processes, taggers: taggers};
	});
var $elm$time$Time$init = $elm$core$Task$succeed(
	A2($elm$time$Time$State, $elm$core$Dict$empty, $elm$core$Dict$empty));
var $elm$time$Time$addMySub = F2(
	function (_v0, state) {
		var interval = _v0.a;
		var tagger = _v0.b;
		var _v1 = A2($elm$core$Dict$get, interval, state);
		if (_v1.$ === 'Nothing') {
			return A3(
				$elm$core$Dict$insert,
				interval,
				_List_fromArray(
					[tagger]),
				state);
		} else {
			var taggers = _v1.a;
			return A3(
				$elm$core$Dict$insert,
				interval,
				A2($elm$core$List$cons, tagger, taggers),
				state);
		}
	});
var $elm$time$Time$Name = function (a) {
	return {$: 'Name', a: a};
};
var $elm$time$Time$Offset = function (a) {
	return {$: 'Offset', a: a};
};
var $elm$time$Time$Zone = F2(
	function (a, b) {
		return {$: 'Zone', a: a, b: b};
	});
var $elm$time$Time$customZone = $elm$time$Time$Zone;
var $elm$time$Time$setInterval = _Time_setInterval;
var $elm$time$Time$spawnHelp = F3(
	function (router, intervals, processes) {
		if (!intervals.b) {
			return $elm$core$Task$succeed(processes);
		} else {
			var interval = intervals.a;
			var rest = intervals.b;
			var spawnTimer = $elm$core$Process$spawn(
				A2(
					$elm$time$Time$setInterval,
					interval,
					A2($elm$core$Platform$sendToSelf, router, interval)));
			var spawnRest = function (id) {
				return A3(
					$elm$time$Time$spawnHelp,
					router,
					rest,
					A3($elm$core$Dict$insert, interval, id, processes));
			};
			return A2($elm$core$Task$andThen, spawnRest, spawnTimer);
		}
	});
var $elm$time$Time$onEffects = F3(
	function (router, subs, _v0) {
		var processes = _v0.processes;
		var rightStep = F3(
			function (_v6, id, _v7) {
				var spawns = _v7.a;
				var existing = _v7.b;
				var kills = _v7.c;
				return _Utils_Tuple3(
					spawns,
					existing,
					A2(
						$elm$core$Task$andThen,
						function (_v5) {
							return kills;
						},
						$elm$core$Process$kill(id)));
			});
		var newTaggers = A3($elm$core$List$foldl, $elm$time$Time$addMySub, $elm$core$Dict$empty, subs);
		var leftStep = F3(
			function (interval, taggers, _v4) {
				var spawns = _v4.a;
				var existing = _v4.b;
				var kills = _v4.c;
				return _Utils_Tuple3(
					A2($elm$core$List$cons, interval, spawns),
					existing,
					kills);
			});
		var bothStep = F4(
			function (interval, taggers, id, _v3) {
				var spawns = _v3.a;
				var existing = _v3.b;
				var kills = _v3.c;
				return _Utils_Tuple3(
					spawns,
					A3($elm$core$Dict$insert, interval, id, existing),
					kills);
			});
		var _v1 = A6(
			$elm$core$Dict$merge,
			leftStep,
			bothStep,
			rightStep,
			newTaggers,
			processes,
			_Utils_Tuple3(
				_List_Nil,
				$elm$core$Dict$empty,
				$elm$core$Task$succeed(_Utils_Tuple0)));
		var spawnList = _v1.a;
		var existingDict = _v1.b;
		var killTask = _v1.c;
		return A2(
			$elm$core$Task$andThen,
			function (newProcesses) {
				return $elm$core$Task$succeed(
					A2($elm$time$Time$State, newTaggers, newProcesses));
			},
			A2(
				$elm$core$Task$andThen,
				function (_v2) {
					return A3($elm$time$Time$spawnHelp, router, spawnList, existingDict);
				},
				killTask));
	});
var $elm$time$Time$Posix = function (a) {
	return {$: 'Posix', a: a};
};
var $elm$time$Time$millisToPosix = $elm$time$Time$Posix;
var $elm$time$Time$now = _Time_now($elm$time$Time$millisToPosix);
var $elm$time$Time$onSelfMsg = F3(
	function (router, interval, state) {
		var _v0 = A2($elm$core$Dict$get, interval, state.taggers);
		if (_v0.$ === 'Nothing') {
			return $elm$core$Task$succeed(state);
		} else {
			var taggers = _v0.a;
			var tellTaggers = function (time) {
				return $elm$core$Task$sequence(
					A2(
						$elm$core$List$map,
						function (tagger) {
							return A2(
								$elm$core$Platform$sendToApp,
								router,
								tagger(time));
						},
						taggers));
			};
			return A2(
				$elm$core$Task$andThen,
				function (_v1) {
					return $elm$core$Task$succeed(state);
				},
				A2($elm$core$Task$andThen, tellTaggers, $elm$time$Time$now));
		}
	});
var $elm$time$Time$subMap = F2(
	function (f, _v0) {
		var interval = _v0.a;
		var tagger = _v0.b;
		return A2(
			$elm$time$Time$Every,
			interval,
			A2($elm$core$Basics$composeL, f, tagger));
	});
_Platform_effectManagers['Time'] = _Platform_createManager($elm$time$Time$init, $elm$time$Time$onEffects, $elm$time$Time$onSelfMsg, 0, $elm$time$Time$subMap);
var $elm$time$Time$subscription = _Platform_leaf('Time');
var $elm$time$Time$every = F2(
	function (interval, tagger) {
		return $elm$time$Time$subscription(
			A2($elm$time$Time$Every, interval, tagger));
	});
var $author$project$Shared$responseReceiver = _Platform_incomingPort('responseReceiver', $elm$json$Json$Decode$string);
var $author$project$Shared$subscriptions = function (_v0) {
	return $elm$core$Platform$Sub$batch(
		_List_fromArray(
			[
				$author$project$Shared$responseReceiver($author$project$Shared$decodeWS),
				$author$project$Shared$connection($author$project$Shared$decodeWS),
				A2($elm$time$Time$every, 1000, $author$project$Shared$QueryPlayers)
			]));
};
var $author$project$Spa$Generated$Pages$bundle = function (bigModel) {
	switch (bigModel.$) {
		case 'Top__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.top.bundle(model);
		case 'Addons__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.addons.bundle(model);
		case 'Browser__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.browser.bundle(model);
		case 'Help__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.help.bundle(model);
		case 'Lab__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.lab.bundle(model);
		case 'Movies__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.movies.bundle(model);
		case 'Music__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.music.bundle(model);
		case 'NotFound__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.notFound.bundle(model);
		case 'Playlists__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.playlists.bundle(model);
		case 'Thumbsup__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.thumbsup.bundle(model);
		case 'Tvshows__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.tvshows.bundle(model);
		case 'Movies__Recent__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.movies__recent.bundle(model);
		case 'Music__Albums__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.music__albums.bundle(model);
		case 'Music__Artists__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.music__artists.bundle(model);
		case 'Music__Genres__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.music__genres.bundle(model);
		case 'Music__Videos__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.music__videos.bundle(model);
		case 'Settings__Addons__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__addons.bundle(model);
		case 'Settings__Nav__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__nav.bundle(model);
		case 'Settings__Search__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__search.bundle(model);
		case 'Settings__Web__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__web.bundle(model);
		case 'Tvshows__Recent__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.tvshows__recent.bundle(model);
		case 'Browser__Source_String__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.browser__source_string.bundle(model);
		case 'Playlists__Name_String__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.playlists__name_string.bundle(model);
		case 'Videoplayer__Movieid_Int__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.videoplayer__movieid_int.bundle(model);
		case 'Music__Top__Top__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.music__top__top.bundle(model);
		case 'Settings__Kodi__Games__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__games.bundle(model);
		case 'Settings__Kodi__Interface__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__interface.bundle(model);
		case 'Settings__Kodi__Media__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__media.bundle(model);
		case 'Settings__Kodi__Player__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__player.bundle(model);
		case 'Settings__Kodi__Pvr__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__pvr.bundle(model);
		case 'Settings__Kodi__Services__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__services.bundle(model);
		case 'Settings__Kodi__System__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.settings__kodi__system.bundle(model);
		case 'Music__Album__Albumid_Int__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.music__album__albumid_int.bundle(model);
		case 'Music__Artist__Artistid_Int__Model':
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.music__artist__artistid_int.bundle(model);
		default:
			var model = bigModel.a;
			return $author$project$Spa$Generated$Pages$pages.music__genre__genre_string.bundle(model);
	}
};
var $author$project$Spa$Generated$Pages$subscriptions = A2(
	$elm$core$Basics$composeR,
	$author$project$Spa$Generated$Pages$bundle,
	function ($) {
		return $.subscriptions;
	});
var $author$project$Main$subscriptions = function (model) {
	return $elm$core$Platform$Sub$batch(
		_List_fromArray(
			[
				A2(
				$elm$core$Platform$Sub$map,
				$author$project$Main$Shared,
				$author$project$Shared$subscriptions(model.shared)),
				A2(
				$elm$core$Platform$Sub$map,
				$author$project$Main$Pages,
				$author$project$Spa$Generated$Pages$subscriptions(model.page)),
				$elm$browser$Browser$Events$onResize(
				F2(
					function (w, h) {
						return A2($author$project$Main$GotNewSize, w, h);
					}))
			]));
};
var $mdgriffith$elm_ui$Internal$Model$FontFamily = F2(
	function (a, b) {
		return {$: 'FontFamily', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Flag$fontFamily = $mdgriffith$elm_ui$Internal$Flag$flag(5);
var $elm$core$String$toLower = _String_toLower;
var $elm$core$String$words = _String_words;
var $mdgriffith$elm_ui$Internal$Model$renderFontClassName = F2(
	function (font, current) {
		return _Utils_ap(
			current,
			function () {
				switch (font.$) {
					case 'Serif':
						return 'serif';
					case 'SansSerif':
						return 'sans-serif';
					case 'Monospace':
						return 'monospace';
					case 'Typeface':
						var name = font.a;
						return A2(
							$elm$core$String$join,
							'-',
							$elm$core$String$words(
								$elm$core$String$toLower(name)));
					case 'ImportFont':
						var name = font.a;
						var url = font.b;
						return A2(
							$elm$core$String$join,
							'-',
							$elm$core$String$words(
								$elm$core$String$toLower(name)));
					default:
						var name = font.a.name;
						return A2(
							$elm$core$String$join,
							'-',
							$elm$core$String$words(
								$elm$core$String$toLower(name)));
				}
			}());
	});
var $mdgriffith$elm_ui$Element$Font$family = function (families) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$fontFamily,
		A2(
			$mdgriffith$elm_ui$Internal$Model$FontFamily,
			A3($elm$core$List$foldl, $mdgriffith$elm_ui$Internal$Model$renderFontClassName, 'ff-', families),
			families));
};
var $mdgriffith$elm_ui$Element$htmlAttribute = $mdgriffith$elm_ui$Internal$Model$Attr;
var $author$project$Colors$navBackground = $author$project$Colors$white;
var $author$project$Spa$Document$frame = F5(
	function (header, playerBar, rightSidebar, leftSidebar, dialogBox) {
		return A2(
			$mdgriffith$elm_ui$Element$column,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'pointer-events', 'none')),
					$mdgriffith$elm_ui$Element$inFront(dialogBox)
				]),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$row,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
						]),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Element$column,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
								]),
							_List_fromArray(
								[
									header,
									A2(
									$mdgriffith$elm_ui$Element$column,
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$width(
											$mdgriffith$elm_ui$Element$px(50)),
											$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
											$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$navBackground)
										]),
									_List_fromArray(
										[leftSidebar]))
								])),
							A2(
							$mdgriffith$elm_ui$Element$column,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
								]),
							_List_fromArray(
								[rightSidebar]))
						])),
					playerBar
				]));
	});
var $mdgriffith$elm_ui$Internal$Model$OnlyDynamic = F2(
	function (a, b) {
		return {$: 'OnlyDynamic', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$StaticRootAndDynamic = F2(
	function (a, b) {
		return {$: 'StaticRootAndDynamic', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$AllowHover = {$: 'AllowHover'};
var $mdgriffith$elm_ui$Internal$Model$Layout = {$: 'Layout'};
var $mdgriffith$elm_ui$Internal$Model$focusDefaultStyle = {
	backgroundColor: $elm$core$Maybe$Nothing,
	borderColor: $elm$core$Maybe$Nothing,
	shadow: $elm$core$Maybe$Just(
		{
			blur: 0,
			color: A4($mdgriffith$elm_ui$Internal$Model$Rgba, 155 / 255, 203 / 255, 1, 1),
			offset: _Utils_Tuple2(0, 0),
			size: 3
		})
};
var $mdgriffith$elm_ui$Internal$Model$optionsToRecord = function (options) {
	var combine = F2(
		function (opt, record) {
			switch (opt.$) {
				case 'HoverOption':
					var hoverable = opt.a;
					var _v4 = record.hover;
					if (_v4.$ === 'Nothing') {
						return _Utils_update(
							record,
							{
								hover: $elm$core$Maybe$Just(hoverable)
							});
					} else {
						return record;
					}
				case 'FocusStyleOption':
					var focusStyle = opt.a;
					var _v5 = record.focus;
					if (_v5.$ === 'Nothing') {
						return _Utils_update(
							record,
							{
								focus: $elm$core$Maybe$Just(focusStyle)
							});
					} else {
						return record;
					}
				default:
					var renderMode = opt.a;
					var _v6 = record.mode;
					if (_v6.$ === 'Nothing') {
						return _Utils_update(
							record,
							{
								mode: $elm$core$Maybe$Just(renderMode)
							});
					} else {
						return record;
					}
			}
		});
	var andFinally = function (record) {
		return {
			focus: function () {
				var _v0 = record.focus;
				if (_v0.$ === 'Nothing') {
					return $mdgriffith$elm_ui$Internal$Model$focusDefaultStyle;
				} else {
					var focusable = _v0.a;
					return focusable;
				}
			}(),
			hover: function () {
				var _v1 = record.hover;
				if (_v1.$ === 'Nothing') {
					return $mdgriffith$elm_ui$Internal$Model$AllowHover;
				} else {
					var hoverable = _v1.a;
					return hoverable;
				}
			}(),
			mode: function () {
				var _v2 = record.mode;
				if (_v2.$ === 'Nothing') {
					return $mdgriffith$elm_ui$Internal$Model$Layout;
				} else {
					var actualMode = _v2.a;
					return actualMode;
				}
			}()
		};
	};
	return andFinally(
		A3(
			$elm$core$List$foldr,
			combine,
			{focus: $elm$core$Maybe$Nothing, hover: $elm$core$Maybe$Nothing, mode: $elm$core$Maybe$Nothing},
			options));
};
var $mdgriffith$elm_ui$Internal$Model$toHtml = F2(
	function (mode, el) {
		switch (el.$) {
			case 'Unstyled':
				var html = el.a;
				return html($mdgriffith$elm_ui$Internal$Model$asEl);
			case 'Styled':
				var styles = el.a.styles;
				var html = el.a.html;
				return A2(
					html,
					mode(styles),
					$mdgriffith$elm_ui$Internal$Model$asEl);
			case 'Text':
				var text = el.a;
				return $mdgriffith$elm_ui$Internal$Model$textElement(text);
			default:
				return $mdgriffith$elm_ui$Internal$Model$textElement('');
		}
	});
var $mdgriffith$elm_ui$Internal$Model$renderRoot = F3(
	function (optionList, attributes, child) {
		var options = $mdgriffith$elm_ui$Internal$Model$optionsToRecord(optionList);
		var embedStyle = function () {
			var _v0 = options.mode;
			if (_v0.$ === 'NoStaticStyleSheet') {
				return $mdgriffith$elm_ui$Internal$Model$OnlyDynamic(options);
			} else {
				return $mdgriffith$elm_ui$Internal$Model$StaticRootAndDynamic(options);
			}
		}();
		return A2(
			$mdgriffith$elm_ui$Internal$Model$toHtml,
			embedStyle,
			A4(
				$mdgriffith$elm_ui$Internal$Model$element,
				$mdgriffith$elm_ui$Internal$Model$asEl,
				$mdgriffith$elm_ui$Internal$Model$div,
				attributes,
				$mdgriffith$elm_ui$Internal$Model$Unkeyed(
					_List_fromArray(
						[child]))));
	});
var $mdgriffith$elm_ui$Internal$Model$SansSerif = {$: 'SansSerif'};
var $mdgriffith$elm_ui$Internal$Model$Typeface = function (a) {
	return {$: 'Typeface', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$rootStyle = function () {
	var families = _List_fromArray(
		[
			$mdgriffith$elm_ui$Internal$Model$Typeface('Open Sans'),
			$mdgriffith$elm_ui$Internal$Model$Typeface('Helvetica'),
			$mdgriffith$elm_ui$Internal$Model$Typeface('Verdana'),
			$mdgriffith$elm_ui$Internal$Model$SansSerif
		]);
	return _List_fromArray(
		[
			A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$bgColor,
			A3(
				$mdgriffith$elm_ui$Internal$Model$Colored,
				'bg-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(
					A4($mdgriffith$elm_ui$Internal$Model$Rgba, 1, 1, 1, 0)),
				'background-color',
				A4($mdgriffith$elm_ui$Internal$Model$Rgba, 1, 1, 1, 0))),
			A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$fontColor,
			A3(
				$mdgriffith$elm_ui$Internal$Model$Colored,
				'fc-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(
					A4($mdgriffith$elm_ui$Internal$Model$Rgba, 0, 0, 0, 1)),
				'color',
				A4($mdgriffith$elm_ui$Internal$Model$Rgba, 0, 0, 0, 1))),
			A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$fontSize,
			$mdgriffith$elm_ui$Internal$Model$FontSize(20)),
			A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$fontFamily,
			A2(
				$mdgriffith$elm_ui$Internal$Model$FontFamily,
				A3($elm$core$List$foldl, $mdgriffith$elm_ui$Internal$Model$renderFontClassName, 'font-', families),
				families))
		]);
}();
var $mdgriffith$elm_ui$Element$layoutWith = F3(
	function (_v0, attrs, child) {
		var options = _v0.options;
		return A3(
			$mdgriffith$elm_ui$Internal$Model$renderRoot,
			options,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$htmlClass(
					A2(
						$elm$core$String$join,
						' ',
						_List_fromArray(
							[$mdgriffith$elm_ui$Internal$Style$classes.root, $mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single]))),
				_Utils_ap($mdgriffith$elm_ui$Internal$Model$rootStyle, attrs)),
			child);
	});
var $mdgriffith$elm_ui$Element$layout = $mdgriffith$elm_ui$Element$layoutWith(
	{options: _List_Nil});
var $mdgriffith$elm_ui$Element$Font$sansSerif = $mdgriffith$elm_ui$Internal$Model$SansSerif;
var $mdgriffith$elm_ui$Element$Font$typeface = $mdgriffith$elm_ui$Internal$Model$Typeface;
var $author$project$Spa$Document$toBrowserDocument = function (_v0) {
	var body = _v0.body;
	var header = _v0.header;
	var playerBar = _v0.playerBar;
	var rightSidebar = _v0.rightSidebar;
	var leftSidebar = _v0.leftSidebar;
	var dialogBox = _v0.dialogBox;
	return {
		body: _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$layout,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$inFront(
						A5($author$project$Spa$Document$frame, header, playerBar, rightSidebar, leftSidebar, dialogBox)),
						$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$greyscaleGray),
						$mdgriffith$elm_ui$Element$Font$size(14),
						$mdgriffith$elm_ui$Element$Font$family(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$typeface('opensans-light'),
								$mdgriffith$elm_ui$Element$Font$sansSerif
							]))
					]),
				A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
						]),
					body.body))
			]),
		title: body.title
	};
};
var $elm$browser$Browser$Navigation$load = _Browser_load;
var $author$project$Spa$Generated$Pages$load = A2(
	$elm$core$Basics$composeR,
	$author$project$Spa$Generated$Pages$bundle,
	function ($) {
		return $.load;
	});
var $elm$browser$Browser$Navigation$pushUrl = _Browser_pushUrl;
var $author$project$Spa$Generated$Pages$save = A2(
	$elm$core$Basics$composeR,
	$author$project$Spa$Generated$Pages$bundle,
	function ($) {
		return $.save;
	});
var $elm$url$Url$addPort = F2(
	function (maybePort, starter) {
		if (maybePort.$ === 'Nothing') {
			return starter;
		} else {
			var port_ = maybePort.a;
			return starter + (':' + $elm$core$String$fromInt(port_));
		}
	});
var $elm$url$Url$addPrefixed = F3(
	function (prefix, maybeSegment, starter) {
		if (maybeSegment.$ === 'Nothing') {
			return starter;
		} else {
			var segment = maybeSegment.a;
			return _Utils_ap(
				starter,
				_Utils_ap(prefix, segment));
		}
	});
var $elm$url$Url$toString = function (url) {
	var http = function () {
		var _v0 = url.protocol;
		if (_v0.$ === 'Http') {
			return 'http://';
		} else {
			return 'https://';
		}
	}();
	return A3(
		$elm$url$Url$addPrefixed,
		'#',
		url.fragment,
		A3(
			$elm$url$Url$addPrefixed,
			'?',
			url.query,
			_Utils_ap(
				A2(
					$elm$url$Url$addPort,
					url.port_,
					_Utils_ap(http, url.host)),
				url.path)));
};
var $author$project$Shared$All = {$: 'All'};
var $author$project$WSDecoder$Connected = {$: 'Connected'};
var $author$project$Components$LayoutType$ConnectionDialog = {$: 'ConnectionDialog'};
var $author$project$WSDecoder$Disconnected = {$: 'Disconnected'};
var $author$project$Shared$One = {$: 'One'};
var $elm$json$Json$Encode$int = _Json_wrap;
var $author$project$WSDecoder$playlistObjEncoder = function (playlistObj) {
	return $elm$json$Json$Encode$object(
		_List_fromArray(
			[
				_Utils_Tuple2(
				'name',
				$elm$json$Json$Encode$string(playlistObj.name)),
				_Utils_Tuple2(
				'songs',
				A2(
					$elm$json$Json$Encode$list,
					$elm$json$Json$Encode$int,
					A2(
						$elm$core$List$map,
						function (song) {
							return song;
						},
						playlistObj.songs)))
			]));
};
var $author$project$WSDecoder$localPlaylistEncoder = function (localPlaylist) {
	return A2(
		$elm$json$Json$Encode$encode,
		0,
		$elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'localPlaylists',
					A2($elm$json$Json$Encode$list, $author$project$WSDecoder$playlistObjEncoder, localPlaylist.localPlaylists))
				])));
};
var $elm$browser$Browser$Navigation$reload = _Browser_reload(false);
var $author$project$Method$methodToStr = function (method) {
	switch (method.$) {
		case 'JSONRPC_Introspect':
			return 'JSONRPC.Introspect';
		case 'JSONRPC_Version':
			return 'JSONRPC.Version';
		case 'JSONRPC_Permission':
			return 'JSONRPC.Permission';
		case 'JSONRPC_Ping':
			return 'JSONRPC.Ping';
		case 'JSONRPC_GetConfiguration':
			return 'JSONRPC.GetConfiguration';
		case 'JSONRPC_SetConfiguration':
			return 'JSONRPC.SetConfiguration';
		case 'JSONRPC_NotifyAll':
			return 'JSONRPC.NotifyAll';
		case 'Player_Open':
			return 'Player.Open';
		case 'Player_GetActivePlayers':
			return 'Player.GetActivePlayers';
		case 'Player_GetPlayers':
			return 'Player.GetPlayers';
		case 'Player_GetProperties':
			return 'Player.GetProperties';
		case 'Player_GetItem':
			return 'Player.GetItem';
		case 'Player_PlayPause':
			return 'Player.PlayPause';
		case 'Player_Stop':
			return 'Player.Stop';
		case 'Player_SetSpeed':
			return 'Player.SetSpeed';
		case 'Player_Seek':
			return 'Player.Seek';
		case 'Player_Move':
			return 'Player.Move';
		case 'Player_Zoom':
			return 'Player.Zoom';
		case 'Player_SetViewMode':
			return 'Player.SetViewMode';
		case 'Player_GetViewMode':
			return 'Player.GetViewMode';
		case 'Player_Rotate':
			return 'Player.Rotate';
		case 'Player_GoTo':
			return 'Player.GoTo';
		case 'Player_SetShuffle':
			return 'Player.SetShuffle';
		case 'Player_SetRepeat':
			return 'Player.SetRepeat';
		case 'Player_SetPartymode':
			return 'Player.SetPartymode';
		case 'Player_SetAudioStream':
			return 'Player.SetAudioStream';
		case 'Player_SetVideoStream':
			return 'Player.SetVideoStream';
		case 'Player_SetSubtitle':
			return 'Player.SetSubtitle';
		case 'Playlist_GetPlaylists':
			return 'Playlist.GetPlaylists';
		case 'Playlist_GetProperties':
			return 'Playlist.GetProperties';
		case 'Playlist_GetItems':
			return 'Playlist.GetItems';
		case 'Playlist_Add':
			return 'Playlist.Add';
		case 'Playlist_Insert':
			return 'Playlist.Insert';
		case 'Playlist_Remove':
			return 'Playlist.Remove';
		case 'Playlist_Clear':
			return 'Playlist.Clear';
		case 'Playlist_Swap':
			return 'Playlist.Swap';
		case 'Files_GetSources':
			return 'Files.GetSources';
		case 'Files_PrepareDownload':
			return 'Files.PrepareDownload';
		case 'Files_Download':
			return 'Files.Download';
		case 'Files_GetDirectory':
			return 'Files.GetDirectory';
		case 'Files_GetFileDetails':
			return 'Files.GetFileDetails';
		case 'Files_SetFileDetails':
			return 'Files.SetFileDetails';
		case 'AudioLibrary_GetProperties':
			return 'AudioLibrary.GetProperties';
		case 'AudioLibrary_GetArtists':
			return 'AudioLibrary.GetArtists';
		case 'AudioLibrary_GetArtistDetails':
			return 'AudioLibrary.GetArtistDetails';
		case 'AudioLibrary_GetAlbums':
			return 'AudioLibrary.GetAlbums';
		case 'AudioLibrary_GetAlbumDetails':
			return 'AudioLibrary.GetAlbumDetails';
		case 'AudioLibrary_GetSongs':
			return 'AudioLibrary.GetSongs';
		case 'AudioLibrary_GetSongDetails':
			return 'AudioLibrary.GetSongDetails';
		case 'AudioLibrary_GetRecentlyAddedAlbums':
			return 'AudioLibrary.GetRecentlyAddedAlbums';
		case 'AudioLibrary_GetRecentlyAddedSongs':
			return 'AudioLibrary.GetRecentlyAddedSongs';
		case 'AudioLibrary_GetRecentlyPlayedAlbums':
			return 'AudioLibrary.GetRecentlyPlayedAlbums';
		case 'AudioLibrary_GetRecentlyPlayedSongs':
			return 'AudioLibrary.GetRecentlyPlayedSongs';
		case 'AudioLibrary_GetGenres':
			return 'AudioLibrary.GetGenres';
		case 'AudioLibrary_GetSources':
			return 'AudioLibrary.GetSources';
		case 'AudioLibrary_GetRoles':
			return 'AudioLibrary.GetRoles';
		case 'AudioLibrary_SetArtistDetails':
			return 'AudioLibrary.SetArtistDetails';
		case 'AudioLibrary_SetAlbumDetails':
			return 'AudioLibrary.SetAlbumDetails';
		case 'AudioLibrary_SetSongDetails':
			return 'AudioLibrary.SetSongDetails';
		case 'AudioLibrary_Scan':
			return 'AudioLibrary.Scan';
		case 'AudioLibrary_Export':
			return 'AudioLibrary.Export';
		case 'AudioLibrary_Clean':
			return 'AudioLibrary.Clean';
		case 'VideoLibrary_GetMovies':
			return 'VideoLibrary.GetMovies';
		case 'VideoLibrary_GetMovieDetails':
			return 'VideoLibrary.GetMovieDetails';
		case 'VideoLibrary_GetMovieSets':
			return 'VideoLibrary.GetMovieSets';
		case 'VideoLibrary_GetMovieSetDetails':
			return 'VideoLibrary.GetMovieSetDetails';
		case 'VideoLibrary_GetTVShows':
			return 'VideoLibrary.GetTVShows';
		case 'VideoLibrary_GetTVShowDetails':
			return 'VideoLibrary.GetTVShowDetails';
		case 'VideoLibrary_GetSeasons':
			return 'VideoLibrary.GetSeasons';
		case 'VideoLibrary_GetSeasonDetails':
			return 'VideoLibrary.GetSeasonDetails';
		case 'VideoLibrary_GetEpisodes':
			return 'VideoLibrary.GetEpisodes';
		case 'VideoLibrary_GetEpisodeDetails':
			return 'VideoLibrary.GetEpisodeDetails';
		case 'VideoLibrary_GetMusicVideos':
			return 'VideoLibrary.GetMusicVideos';
		case 'VideoLibrary_GetMusicVideoDetails':
			return 'VideoLibrary.GetMusicVideoDetails';
		case 'VideoLibrary_GetRecentlyAddedMovies':
			return 'VideoLibrary.GetRecentlyAddedMovies';
		case 'VideoLibrary_GetRecentlyAddedEpisodes':
			return 'VideoLibrary.GetRecentlyAddedEpisodes';
		case 'VideoLibrary_GetRecentlyAddedMusicVideos':
			return 'VideoLibrary.GetRecentlyAddedMusicVideos';
		case 'VideoLibrary_GetInProgressTVShows':
			return 'VideoLibrary.GetInProgressTVShows';
		case 'VideoLibrary_GetGenres':
			return 'VideoLibrary.GetGenres';
		case 'VideoLibrary_GetTags':
			return 'VideoLibrary.GetTags';
		case 'VideoLibrary_SetMovieDetails':
			return 'VideoLibrary.SetMovieDetails';
		case 'VideoLibrary_SetMovieSetDetails':
			return 'VideoLibrary.SetMovieSetDetails';
		case 'VideoLibrary_SetTVShowDetails':
			return 'VideoLibrary.SetTVShowDetails';
		case 'VideoLibrary_SetSeasonDetails':
			return 'VideoLibrary.SetSeasonDetails';
		case 'VideoLibrary_SetEpisodeDetails':
			return 'VideoLibrary.SetEpisodeDetails';
		case 'VideoLibrary_SetMusicVideoDetails':
			return 'VideoLibrary.SetMusicVideoDetails';
		case 'VideoLibrary_RefreshMovie':
			return 'VideoLibrary.RefreshMovie';
		case 'VideoLibrary_RefreshTVShow':
			return 'VideoLibrary.RefreshTVShow';
		case 'VideoLibrary_RefreshEpisode':
			return 'VideoLibrary.RefreshEpisode';
		case 'VideoLibrary_RefreshMusicVideo':
			return 'VideoLibrary.RefreshMusicVideo';
		case 'VideoLibrary_RemoveMovie':
			return 'VideoLibrary.RemoveMovie';
		case 'VideoLibrary_RemoveTVShow':
			return 'VideoLibrary.RemoveTVShow';
		case 'VideoLibrary_RemoveEpisode':
			return 'VideoLibrary.RemoveEpisode';
		case 'VideoLibrary_RemoveMusicVideo':
			return 'VideoLibrary.RemoveMusicVideo';
		case 'VideoLibrary_Scan':
			return 'VideoLibrary.Scan';
		case 'VideoLibrary_Export':
			return 'VideoLibrary.Export';
		case 'VideoLibrary_Clean':
			return 'VideoLibrary.Clean';
		case 'GUI_ActivateWindow':
			return 'GUI.ActivateWindow';
		case 'GUI_ShowNotification':
			return 'GUI.ShowNotification';
		case 'GUI_GetProperties':
			return 'GUI.GetProperties';
		case 'GUI_SetFullscreen':
			return 'GUI.SetFullscreen';
		case 'GUI_SetStereoscopicMode':
			return 'GUI.SetStereoscopicMode';
		case 'GUI_GetStereoscopicModes':
			return 'GUI.GetStereoscopicModes';
		case 'Addons_GetAddons':
			return 'Addons.GetAddons';
		case 'Addons_GetAddonDetails':
			return 'Addons.GetAddonDetails';
		case 'Addons_SetAddonEnabled':
			return 'Addons.SetAddonEnabled';
		case 'Addons_ExecuteAddon':
			return 'Addons.ExecuteAddon';
		case 'PVR_GetProperties':
			return 'PVR.GetProperties';
		case 'PVR_GetChannelGroups':
			return 'PVR.GetChannelGroups';
		case 'PVR_GetChannelGroupDetails':
			return 'PVR.GetChannelGroupDetails';
		case 'PVR_GetChannels':
			return 'PVR.GetChannels';
		case 'PVR_GetChannelDetails':
			return 'PVR.GetChannelDetails';
		case 'PVR_GetBroadcasts':
			return 'PVR.GetBroadcasts';
		case 'PVR_GetBroadcastDetails':
			return 'PVR.GetBroadcastDetails';
		case 'PVR_GetTimers':
			return 'PVR.GetTimers';
		case 'PVR_GetTimerDetails':
			return 'PVR.GetTimerDetails';
		case 'PVR_AddTimer':
			return 'PVR.AddTimer';
		case 'PVR_DeleteTimer':
			return 'PVR.DeleteTimer';
		case 'PVR_ToggleTimer':
			return 'PVR.ToggleTimer';
		case 'PVR_GetRecordings':
			return 'PVR.GetRecordings';
		case 'PVR_GetRecordingDetails':
			return 'PVR.GetRecordingDetails';
		case 'PVR_Record':
			return 'PVR.Record';
		case 'PVR_Scan':
			return 'PVR.Scan';
		case 'Textures_GetTextures':
			return 'Textures.GetTextures';
		case 'Textures_RemoveTexture':
			return 'Textures.RemoveTexture';
		case 'Profiles_GetProfiles':
			return 'Profiles.GetProfiles';
		case 'Profiles_GetCurrentProfile':
			return 'Profiles.GetCurrentProfile';
		case 'Profiles_LoadProfile':
			return 'Profiles.LoadProfile';
		case 'System_GetProperties':
			return 'System.GetProperties';
		case 'System_EjectOpticalDrive':
			return 'System.EjectOpticalDrive';
		case 'System_Shutdown':
			return 'System.Shutdown';
		case 'System_Suspend':
			return 'System.Suspend';
		case 'System_Hibernate':
			return 'System.Hibernate';
		case 'System_Reboot':
			return 'System.Reboot';
		case 'Input_SendText':
			return 'Input.SendText';
		case 'Input_ExecuteAction':
			return 'Input.ExecuteAction';
		case 'Input_ButtonEvent':
			return 'Input.ButtonEvent';
		case 'Input_Left':
			return 'Input.Left';
		case 'Input_Right':
			return 'Input.Right';
		case 'Input_Down':
			return 'Input.Down';
		case 'Input_Up':
			return 'Input.Up';
		case 'Input_Select':
			return 'Input.Select';
		case 'Input_Back':
			return 'Input.Back';
		case 'Input_ContextMenu':
			return 'Input.ContextMenu';
		case 'Input_Info':
			return 'Input.Info';
		case 'Input_Home':
			return 'Input.Home';
		case 'Input_ShowCodec':
			return 'Input.ShowCodec';
		case 'Input_ShowOSD':
			return 'Input.ShowOSD';
		case 'Input_ShowPlayerProcessInfo':
			return 'Input.ShowPlayerProcessInfo';
		case 'Application_GetProperties':
			return 'Application.GetProperties';
		case 'Application_SetVolume':
			return 'Application.SetVolume';
		case 'Application_SetMute':
			return 'Application.SetMute';
		case 'Application_Quit':
			return 'Application.Quit';
		case 'XBMC_GetInfoLabels':
			return 'XBMC.GetInfoLabels';
		case 'XBMC_GetInfoBooleans':
			return 'XBMC.GetInfoBooleans';
		case 'Favourites_GetFavourites':
			return 'Favourites.GetFavourites';
		case 'Favourites_AddFavourite':
			return 'Favourites.AddFavourite';
		case 'Settings_GetSections':
			return 'Settings.GetSections';
		case 'Settings_GetCategories':
			return 'Settings.GetCategories';
		case 'Settings_GetSettings':
			return 'Settings.GetSettings';
		case 'Settings_GetSettingValue':
			return 'Settings.GetSettingValue';
		case 'Settings_SetSettingValue':
			return 'Settings.SetSettingValue';
		default:
			return 'Settings.ResetSettingValue';
	}
};
var $author$project$Request$propertyToStr = function (prop) {
	switch (prop.$) {
		case 'Title':
			return 'title';
		case 'Album':
			return 'album';
		case 'Artist':
			return 'artist';
		case 'Season':
			return 'season';
		case 'Episode':
			return 'episode';
		case 'Duration':
			return 'duration';
		case 'Showtitle':
			return 'showtitle';
		case 'TVshowid':
			return 'tvshowid';
		case 'Thumbnail':
			return 'thumbnail';
		case 'File':
			return 'file';
		case 'Fanart':
			return 'fanart';
		case 'Streamdetails':
			return 'streamdetails';
		case 'Percentage':
			return 'percentage';
		case 'Time':
			return 'time';
		case 'Totaltime':
			return 'totaltime';
		default:
			return 'speed';
	}
};
var $author$project$Request$paramsToObj = function (params) {
	if (params.$ === 'Nothing') {
		return $elm$json$Json$Encode$string('Nothing');
	} else {
		var param = params.a;
		var _v1 = param.playerid;
		if (_v1.$ === 'Nothing') {
			var _v2 = param.properties;
			if (_v2.$ === 'Nothing') {
				return $elm$json$Json$Encode$object(_List_Nil);
			} else {
				var properties = _v2.a;
				var _v3 = param.songid;
				if (_v3.$ === 'Nothing') {
					return $elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'properties',
								A2(
									$elm$json$Json$Encode$list,
									$elm$json$Json$Encode$string,
									A2(
										$elm$core$List$map,
										$author$project$Request$propertyToStr,
										A2($elm$core$Maybe$withDefault, _List_Nil, param.properties))))
							]));
				} else {
					var songid = _v3.a;
					return $elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'songid',
								$elm$json$Json$Encode$int(
									A2($elm$core$Maybe$withDefault, 0, param.songid))),
								_Utils_Tuple2(
								'properties',
								A2(
									$elm$json$Json$Encode$list,
									$elm$json$Json$Encode$string,
									A2(
										$elm$core$List$map,
										$author$project$Request$propertyToStr,
										A2($elm$core$Maybe$withDefault, _List_Nil, param.properties))))
							]));
				}
			}
		} else {
			var playerid = _v1.a;
			var _v4 = param.properties;
			if (_v4.$ === 'Nothing') {
				return $elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'playerid',
							$elm$json$Json$Encode$int(
								A2($elm$core$Maybe$withDefault, 0, param.playerid)))
						]));
			} else {
				var properties = _v4.a;
				return $elm$json$Json$Encode$object(
					_List_fromArray(
						[
							_Utils_Tuple2(
							'playerid',
							$elm$json$Json$Encode$int(
								A2($elm$core$Maybe$withDefault, 0, param.playerid))),
							_Utils_Tuple2(
							'properties',
							A2(
								$elm$json$Json$Encode$list,
								$elm$json$Json$Encode$string,
								A2(
									$elm$core$List$map,
									$author$project$Request$propertyToStr,
									A2($elm$core$Maybe$withDefault, _List_Nil, param.properties))))
						]));
			}
		}
	}
};
var $author$project$Request$request = F2(
	function (method, params) {
		return A2(
			$elm$json$Json$Encode$encode,
			0,
			function () {
				if (params.$ === 'Nothing') {
					return $elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'jsonrpc',
								$elm$json$Json$Encode$string('2.0')),
								_Utils_Tuple2(
								'method',
								$elm$json$Json$Encode$string(
									$author$project$Method$methodToStr(method))),
								_Utils_Tuple2(
								'id',
								$elm$json$Json$Encode$int(1))
							]));
				} else {
					var param = params.a;
					return $elm$json$Json$Encode$object(
						_List_fromArray(
							[
								_Utils_Tuple2(
								'jsonrpc',
								$elm$json$Json$Encode$string('2.0')),
								_Utils_Tuple2(
								'method',
								$elm$json$Json$Encode$string(
									$author$project$Method$methodToStr(method))),
								_Utils_Tuple2(
								'params',
								$author$project$Request$paramsToObj(
									$elm$core$Maybe$Just(
										{playerid: param.playerid, properties: param.properties, songid: param.songid}))),
								_Utils_Tuple2(
								'id',
								$elm$json$Json$Encode$int(1))
							]));
				}
			}());
	});
var $author$project$Shared$setStorage = _Platform_outgoingPort('setStorage', $elm$json$Json$Encode$string);
var $carwow$elm_slider$SingleSlider$update = F2(
	function (value, _v0) {
		var slider = _v0.a;
		var valueAttributes = slider.valueAttributes;
		return $carwow$elm_slider$SingleSlider$SingleSlider(
			{
				commonAttributes: slider.commonAttributes,
				valueAttributes: _Utils_update(
					valueAttributes,
					{value: value})
			});
	});
var $author$project$Shared$update = F2(
	function (msg, model) {
		switch (msg.$) {
			case 'Navigate':
				var route = msg.a;
				return _Utils_Tuple2(
					model,
					A2(
						$elm$browser$Browser$Navigation$pushUrl,
						model.key,
						$author$project$Spa$Generated$Route$toString(route)));
			case 'Request':
				var method = msg.a;
				var params = msg.b;
				if (params.$ === 'Nothing') {
					return _Utils_Tuple2(
						model,
						$author$project$Shared$sendAction(
							A2($author$project$Request$request, method, $elm$core$Maybe$Nothing)));
				} else {
					var param = params.a;
					return _Utils_Tuple2(
						model,
						$author$project$Shared$sendAction(
							A2(
								$author$project$Request$request,
								method,
								$elm$core$Maybe$Just(
									{playerid: param.playerid, properties: param.properties, songid: $elm$core$Maybe$Nothing}))));
				}
			case 'Recv':
				var state = msg.a;
				switch (state) {
					case 'Connected':
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{connection: $author$project$WSDecoder$Connected, showDialog: $author$project$Components$LayoutType$None}),
							$elm$core$Platform$Cmd$none);
					case 'Disconnected':
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{connection: $author$project$WSDecoder$Disconnected, showDialog: $author$project$Components$LayoutType$ConnectionDialog}),
							$elm$core$Platform$Cmd$none);
					default:
						return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
				}
			case 'PlayPause':
				return _Utils_Tuple2(
					model,
					$author$project$Shared$sendAction('{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "playpause" }, "id": 1 }'));
			case 'SkipForward':
				return _Utils_Tuple2(
					model,
					$author$project$Shared$sendAction('{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "skipnext" }, "id": 1 }'));
			case 'SkipPrevious':
				return _Utils_Tuple2(
					model,
					$author$project$Shared$sendAction('{ "jsonrpc": "2.0", "method": "Input.ExecuteAction", "params": { "action": "skipprevious" }, "id": 1 }'));
			case 'ToggleMute':
				return _Utils_Tuple2(
					model,
					$author$project$Shared$sendAction('{"jsonrpc": "2.0","method": "Application.SetMute","params": { "mute": "toggle" },"id": 1}'));
			case 'ToggleShuffle':
				var _v3 = model.shuffle;
				if (!_v3) {
					return _Utils_Tuple2(
						_Utils_update(
							model,
							{shuffle: true}),
						$author$project$Shared$sendAction('{"jsonrpc":"2.0","method":"Player.SetShuffle","params":{"playerid":0,"shuffle":true},"id":1}'));
				} else {
					return _Utils_Tuple2(
						_Utils_update(
							model,
							{shuffle: false}),
						$author$project$Shared$sendAction('{"jsonrpc":"2.0","method":"Player.SetShuffle","params":{"playerid":0,"shuffle":false},"id":1}'));
				}
			case 'ToggleRepeat':
				var _v4 = model.repeat;
				switch (_v4.$) {
					case 'Off':
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{repeat: $author$project$Shared$One}),
							$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "Player.SetRepeat", "params": { "playerid": 0, "repeat": "one" }, "id": 1}'));
					case 'One':
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{repeat: $author$project$Shared$All}),
							$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "Player.SetRepeat", "params": { "playerid": 0, "repeat": "all" }, "id": 1}'));
					default:
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{repeat: $author$project$Shared$Off}),
							$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "Player.SetRepeat", "params": { "playerid": 0, "repeat": "off" }, "id": 1}'));
				}
			case 'QueryPlayers':
				return _Utils_Tuple2(
					model,
					$author$project$Shared$sendAction('{"jsonrpc": "2.0", "method": "Player.GetActivePlayers", "id": 1}'));
			case 'ReceiveParamsResponse':
				return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
			case 'ReceiveResultResponse':
				var result = msg.a;
				switch (result.$) {
					case 'ResultA':
						return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
					case 'ResultB':
						var playerObjects = result.a;
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{players: playerObjects}),
							$author$project$Shared$sendActions(
								A2(
									$elm$core$List$map,
									function (player) {
										if (player.$ === 'PlayerA') {
											var playerid = player.a;
											var speed = player.b;
											return '';
										} else {
											var playerid = player.a;
											var playertype = player.b;
											var ptype = player.c;
											if (ptype.$ === 'Video') {
												return '{"jsonrpc": "2.0", "method": "Player.GetItem", "params": { "properties": ["title", "album", "artist", "season", "episode", "duration", "showtitle", "tvshowid", "thumbnail", "file", "fanart", "streamdetails"], "playerid": ' + ($elm$core$String$fromInt(playerid) + ' }, "id": "VideoGetItem"}');
											} else {
												return '{"jsonrpc": "2.0", "method": "Player.GetItem", "params": { "properties": ["title", "album", "artist", "duration", "genre", "thumbnail", "file", "fanart", "streamdetails"], "playerid": ' + ($elm$core$String$fromInt(playerid) + ' }, "id": "AudioGetItem"}');
											}
										}
									},
									model.players)));
					case 'ResultC':
						var item = result.a;
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{
									currentlyPlaying: $elm$core$Maybe$Just(item)
								}),
							$author$project$Shared$sendActions(
								_List_fromArray(
									['{"jsonrpc":"2.0","method":"Player.GetProperties","params":{"playerid":0,"properties":["percentage", "speed"]},"id":"0"}', '{"jsonrpc": "2.0", "method": "Application.GetProperties", "params" : { "properties" : [ "volume", "muted" ] }, "id": 0}'])));
					case 'ResultD':
						var songlist = result.a;
						var genrelist = $elm_community$list_extra$List$Extra$unique(
							A2(
								$elm$core$List$concatMap,
								function (song) {
									return song.genre;
								},
								songlist));
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{genre_list: genrelist, song_list: songlist}),
							$elm$core$Platform$Cmd$none);
					case 'ResultE':
						var artistlist = result.a;
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{artist_list: artistlist}),
							$elm$core$Platform$Cmd$none);
					case 'ResultF':
						var albumlist = result.a;
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{album_list: albumlist}),
							$elm$core$Platform$Cmd$none);
					case 'ResultG':
						var movielist = result.a;
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{movie_list: movielist}),
							$elm$core$Platform$Cmd$none);
					case 'ResultH':
						var percent = result.a;
						var playing = result.b;
						switch (playing) {
							case 0:
								var newSlider = A2($carwow$elm_slider$SingleSlider$update, percent, model.progressSlider);
								return _Utils_Tuple2(
									_Utils_update(
										model,
										{playing: false, progressSlider: newSlider}),
									$elm$core$Platform$Cmd$none);
							case 1:
								var newSlider = A2($carwow$elm_slider$SingleSlider$update, percent, model.progressSlider);
								return _Utils_Tuple2(
									_Utils_update(
										model,
										{playing: true, progressSlider: newSlider}),
									$elm$core$Platform$Cmd$none);
							default:
								var newSlider = A2($carwow$elm_slider$SingleSlider$update, percent, model.progressSlider);
								return _Utils_Tuple2(
									_Utils_update(
										model,
										{progressSlider: newSlider}),
									$elm$core$Platform$Cmd$none);
						}
					case 'ResultI':
						var sourcelist = result.a;
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{
									source_list: _Utils_ap(model.source_list, sourcelist)
								}),
							$elm$core$Platform$Cmd$none);
					case 'ResultJ':
						var muted = result.a;
						var volume = result.b;
						var newSlider = A2($carwow$elm_slider$SingleSlider$update, volume, model.volumeSlider);
						if (!muted) {
							return _Utils_Tuple2(
								_Utils_update(
									model,
									{volumeSlider: newSlider}),
								$elm$core$Platform$Cmd$none);
						} else {
							return _Utils_Tuple2(
								_Utils_update(
									model,
									{volumeSlider: newSlider}),
								$elm$core$Platform$Cmd$none);
						}
					default:
						var filelist = result.a;
						return _Utils_Tuple2(
							_Utils_update(
								model,
								{file_list: filelist}),
							$elm$core$Platform$Cmd$none);
				}
			case 'ToggleRightSidebar':
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{rightSidebarExtended: !model.rightSidebarExtended}),
					$elm$core$Platform$Cmd$none);
			case 'ToggleControlMenu':
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{controlMenu: !model.controlMenu}),
					$elm$core$Platform$Cmd$none);
			case 'SendTextToKodi':
				return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
			case 'ScanVideoLibrary':
				return _Utils_Tuple2(
					model,
					$author$project$Shared$sendAction('{ "jsonrpc": "2.0", "method": "VideoLibrary.Scan", "id": "videoScan"}'));
			case 'ScanMusicLibrary':
				return _Utils_Tuple2(
					model,
					$author$project$Shared$sendAction('{ "jsonrpc": "2.0", "method": "AudioLibrary.Scan", "id": "audioScan"}'));
			case 'VolumeSliderChange':
				var newValue = msg.a;
				var newSlider = A2($carwow$elm_slider$SingleSlider$update, newValue, model.volumeSlider);
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{volumeSlider: newSlider}),
					$author$project$Shared$sendAction(
						'{"jsonrpc":"2.0","method":"Application.SetVolume","id":1,"params":{"volume":' + ($elm$core$String$fromFloat(newValue) + '}}')));
			case 'ProgressSliderChange':
				var newValue = msg.a;
				var newSlider = A2($carwow$elm_slider$SingleSlider$update, newValue, model.progressSlider);
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{progressSlider: newSlider}),
					$author$project$Shared$sendAction(
						'{"jsonrpc":"2.0", "method":"Player.Seek", "id":1, "params": { "playerid":0, "value":' + ($elm$core$String$fromFloat(newValue) + '}}')));
			case 'SearchChanged':
				var searchString = msg.a;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{searchString: searchString}),
					$elm$core$Platform$Cmd$none);
			case 'AttemptReconnectionDialog':
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{showDialog: $author$project$Components$LayoutType$None}),
					$elm$browser$Browser$Navigation$reload);
			case 'CloseDialog':
				var playlistObj = {name: model.playlistName, songs: _List_Nil};
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{
							playlistName: '',
							playlists: {
								localPlaylists: _Utils_ap(
									model.playlists.localPlaylists,
									_List_fromArray(
										[playlistObj]))
							},
							showDialog: $author$project$Components$LayoutType$None
						}),
					$author$project$Shared$setStorage(
						$author$project$WSDecoder$localPlaylistEncoder(model.playlists)));
			default:
				var name = msg.a;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{playlistName: name, showDialog: $author$project$Components$LayoutType$TextInputDialog}),
					$elm$core$Platform$Cmd$none);
		}
	});
var $author$project$Spa$Generated$Pages$update = F2(
	function (bigMsg, bigModel) {
		var _v0 = _Utils_Tuple2(bigMsg, bigModel);
		_v0$35:
		while (true) {
			switch (_v0.a.$) {
				case 'Top__Msg':
					if (_v0.b.$ === 'Top__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.top.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Addons__Msg':
					if (_v0.b.$ === 'Addons__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.addons.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Browser__Msg':
					if (_v0.b.$ === 'Browser__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.browser.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Help__Msg':
					if (_v0.b.$ === 'Help__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.help.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Lab__Msg':
					if (_v0.b.$ === 'Lab__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.lab.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Movies__Msg':
					if (_v0.b.$ === 'Movies__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.movies.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Music__Msg':
					if (_v0.b.$ === 'Music__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.music.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'NotFound__Msg':
					if (_v0.b.$ === 'NotFound__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.notFound.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Playlists__Msg':
					if (_v0.b.$ === 'Playlists__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.playlists.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Thumbsup__Msg':
					if (_v0.b.$ === 'Thumbsup__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.thumbsup.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Tvshows__Msg':
					if (_v0.b.$ === 'Tvshows__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.tvshows.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Movies__Recent__Msg':
					if (_v0.b.$ === 'Movies__Recent__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.movies__recent.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Music__Albums__Msg':
					if (_v0.b.$ === 'Music__Albums__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.music__albums.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Music__Artists__Msg':
					if (_v0.b.$ === 'Music__Artists__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.music__artists.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Music__Genres__Msg':
					if (_v0.b.$ === 'Music__Genres__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.music__genres.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Music__Videos__Msg':
					if (_v0.b.$ === 'Music__Videos__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.music__videos.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Addons__Msg':
					if (_v0.b.$ === 'Settings__Addons__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__addons.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Nav__Msg':
					if (_v0.b.$ === 'Settings__Nav__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__nav.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Search__Msg':
					if (_v0.b.$ === 'Settings__Search__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__search.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Web__Msg':
					if (_v0.b.$ === 'Settings__Web__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__web.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Tvshows__Recent__Msg':
					if (_v0.b.$ === 'Tvshows__Recent__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.tvshows__recent.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Browser__Source_String__Msg':
					if (_v0.b.$ === 'Browser__Source_String__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.browser__source_string.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Playlists__Name_String__Msg':
					if (_v0.b.$ === 'Playlists__Name_String__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.playlists__name_string.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Videoplayer__Movieid_Int__Msg':
					if (_v0.b.$ === 'Videoplayer__Movieid_Int__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.videoplayer__movieid_int.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Music__Top__Top__Msg':
					if (_v0.b.$ === 'Music__Top__Top__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.music__top__top.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Kodi__Games__Msg':
					if (_v0.b.$ === 'Settings__Kodi__Games__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__kodi__games.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Kodi__Interface__Msg':
					if (_v0.b.$ === 'Settings__Kodi__Interface__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__kodi__interface.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Kodi__Media__Msg':
					if (_v0.b.$ === 'Settings__Kodi__Media__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__kodi__media.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Kodi__Player__Msg':
					if (_v0.b.$ === 'Settings__Kodi__Player__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__kodi__player.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Kodi__Pvr__Msg':
					if (_v0.b.$ === 'Settings__Kodi__Pvr__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__kodi__pvr.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Kodi__Services__Msg':
					if (_v0.b.$ === 'Settings__Kodi__Services__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__kodi__services.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Settings__Kodi__System__Msg':
					if (_v0.b.$ === 'Settings__Kodi__System__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.settings__kodi__system.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Music__Album__Albumid_Int__Msg':
					if (_v0.b.$ === 'Music__Album__Albumid_Int__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.music__album__albumid_int.update, msg, model);
					} else {
						break _v0$35;
					}
				case 'Music__Artist__Artistid_Int__Msg':
					if (_v0.b.$ === 'Music__Artist__Artistid_Int__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.music__artist__artistid_int.update, msg, model);
					} else {
						break _v0$35;
					}
				default:
					if (_v0.b.$ === 'Music__Genre__Genre_String__Model') {
						var msg = _v0.a.a;
						var model = _v0.b.a;
						return A2($author$project$Spa$Generated$Pages$pages.music__genre__genre_string.update, msg, model);
					} else {
						break _v0$35;
					}
			}
		}
		return _Utils_Tuple2(bigModel, $elm$core$Platform$Cmd$none);
	});
var $author$project$Main$update = F2(
	function (msg, model) {
		switch (msg.$) {
			case 'LinkClicked':
				if (msg.a.$ === 'Internal') {
					var url = msg.a.a;
					return _Utils_Tuple2(
						model,
						A2(
							$elm$browser$Browser$Navigation$pushUrl,
							model.shared.key,
							$elm$url$Url$toString(url)));
				} else {
					var href = msg.a.a;
					return _Utils_Tuple2(
						model,
						$elm$browser$Browser$Navigation$load(href));
				}
			case 'UrlChanged':
				var url = msg.a;
				var original = model.shared;
				var shared = _Utils_update(
					original,
					{url: url});
				var _v1 = A2(
					$author$project$Spa$Generated$Pages$init,
					$author$project$Main$fromUrl(url),
					shared);
				var page = _v1.a;
				var pageCmd = _v1.b;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{
							page: page,
							shared: A2($author$project$Spa$Generated$Pages$save, page, shared)
						}),
					A2($elm$core$Platform$Cmd$map, $author$project$Main$Pages, pageCmd));
			case 'Shared':
				var sharedMsg = msg.a;
				var _v2 = A2($author$project$Shared$update, sharedMsg, model.shared);
				var shared = _v2.a;
				var sharedCmd = _v2.b;
				var _v3 = A2($author$project$Spa$Generated$Pages$load, model.page, shared);
				var page = _v3.a;
				var pageCmd = _v3.b;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{page: page, shared: shared}),
					$elm$core$Platform$Cmd$batch(
						_List_fromArray(
							[
								A2($elm$core$Platform$Cmd$map, $author$project$Main$Shared, sharedCmd),
								A2($elm$core$Platform$Cmd$map, $author$project$Main$Pages, pageCmd)
							])));
			case 'Pages':
				var pageMsg = msg.a;
				var _v4 = A2($author$project$Spa$Generated$Pages$update, pageMsg, model.page);
				var page = _v4.a;
				var pageCmd = _v4.b;
				var shared = A2($author$project$Spa$Generated$Pages$save, page, model.shared);
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{page: page, shared: shared}),
					A2($elm$core$Platform$Cmd$map, $author$project$Main$Pages, pageCmd));
			default:
				var width = msg.a;
				var height = msg.b;
				var shared = model.shared;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{
							shared: _Utils_update(
								shared,
								{windowHeight: height, windowWidth: width})
						}),
					$elm$core$Platform$Cmd$none);
		}
	});
var $author$project$Shared$AttemptReconnectionDialog = {$: 'AttemptReconnectionDialog'};
var $author$project$Shared$CloseDialog = {$: 'CloseDialog'};
var $author$project$Shared$NewPlaylist = function (a) {
	return {$: 'NewPlaylist', a: a};
};
var $author$project$Request$Params = F3(
	function (playerid, properties, limits) {
		return {limits: limits, playerid: playerid, properties: properties};
	});
var $author$project$Shared$PlayPause = {$: 'PlayPause'};
var $author$project$Method$Player_SetRepeat = {$: 'Player_SetRepeat'};
var $author$project$Shared$Request = F2(
	function (a, b) {
		return {$: 'Request', a: a, b: b};
	});
var $author$project$Shared$ScanMusicLibrary = {$: 'ScanMusicLibrary'};
var $author$project$Shared$ScanVideoLibrary = {$: 'ScanVideoLibrary'};
var $author$project$Shared$SearchChanged = function (a) {
	return {$: 'SearchChanged', a: a};
};
var $author$project$Shared$SendTextToKodi = {$: 'SendTextToKodi'};
var $author$project$Shared$SkipForward = {$: 'SkipForward'};
var $author$project$Shared$SkipPrevious = {$: 'SkipPrevious'};
var $author$project$Shared$ToggleControlMenu = {$: 'ToggleControlMenu'};
var $author$project$Shared$ToggleMute = {$: 'ToggleMute'};
var $author$project$Shared$ToggleRightSidebar = {$: 'ToggleRightSidebar'};
var $author$project$Shared$ToggleShuffle = {$: 'ToggleShuffle'};
var $author$project$Components$DialogView$body = A2(
	$mdgriffith$elm_ui$Element$column,
	_List_fromArray(
		[
			$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
		]),
	_List_fromArray(
		[
			A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[$mdgriffith$elm_ui$Element$centerX]),
			$mdgriffith$elm_ui$Element$text('Lost connection to Kodi'))
		]));
var $mdgriffith$elm_ui$Internal$Model$CenterY = {$: 'CenterY'};
var $mdgriffith$elm_ui$Element$centerY = $mdgriffith$elm_ui$Internal$Model$AlignY($mdgriffith$elm_ui$Internal$Model$CenterY);
var $mdgriffith$elm_ui$Internal$Flag$fontWeight = $mdgriffith$elm_ui$Internal$Flag$flag(13);
var $mdgriffith$elm_ui$Element$Font$bold = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$fontWeight, $mdgriffith$elm_ui$Internal$Style$classes.bold);
var $mdgriffith$elm_ui$Element$padding = function (x) {
	var f = x;
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$padding,
		A5(
			$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
			'p-' + $elm$core$String$fromInt(x),
			f,
			f,
			f,
			f));
};
var $author$project$Components$DialogView$footerButtons = function (closeDialogMsg) {
	return A2(
		$mdgriffith$elm_ui$Element$row,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$padding(2),
				$mdgriffith$elm_ui$Element$spacing(5)
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$Input$button,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$cerulean),
						$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$white),
						$mdgriffith$elm_ui$Element$Font$bold,
						$mdgriffith$elm_ui$Element$Border$rounded(3),
						A2($mdgriffith$elm_ui$Element$paddingXY, 30, 12),
						$mdgriffith$elm_ui$Element$centerX,
						$mdgriffith$elm_ui$Element$mouseOver(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$cerulean),
								$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$grey)
							]))
					]),
				{
					label: $mdgriffith$elm_ui$Element$text('ATTEMPT TO RECONNECT'),
					onPress: $elm$core$Maybe$Just(closeDialogMsg)
				})
			]));
};
var $author$project$Colors$red = A3($mdgriffith$elm_ui$Element$rgb255, 250, 0, 0);
var $author$project$Components$DialogView$config = function (closeDialogMsg) {
	return {
		body: $elm$core$Maybe$Just($author$project$Components$DialogView$body),
		bodyAttributes: _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$padding(20),
				$mdgriffith$elm_ui$Element$Font$size(24),
				$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$grey)
			]),
		closeMessage: $elm$core$Maybe$Just(closeDialogMsg),
		containerAttributes: _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$white),
				$mdgriffith$elm_ui$Element$Border$rounded(5),
				$mdgriffith$elm_ui$Element$centerX,
				$mdgriffith$elm_ui$Element$centerY,
				$mdgriffith$elm_ui$Element$padding(10),
				$mdgriffith$elm_ui$Element$spacing(20),
				$mdgriffith$elm_ui$Element$width(
				$mdgriffith$elm_ui$Element$px(400))
			]),
		footer: $elm$core$Maybe$Just(
			$author$project$Components$DialogView$footerButtons(closeDialogMsg)),
		footerAttributes: _List_Nil,
		header: $elm$core$Maybe$Just(
			$mdgriffith$elm_ui$Element$text('')),
		headerAttributes: _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$Font$size(24),
				$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$red),
				$mdgriffith$elm_ui$Element$padding(5)
			]),
		maskAttributes: _List_Nil
	};
};
var $author$project$Components$Header$headerHeight = 50;
var $mdgriffith$elm_ui$Element$none = $mdgriffith$elm_ui$Internal$Model$Empty;
var $author$project$Components$PlayerRow$playerHeight = 70;
var $mdgriffith$elm_ui$Element$Input$Above = {$: 'Above'};
var $mdgriffith$elm_ui$Element$Input$Label = F3(
	function (a, b, c) {
		return {$: 'Label', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Element$Input$labelAbove = $mdgriffith$elm_ui$Element$Input$Label($mdgriffith$elm_ui$Element$Input$Above);
var $mdgriffith$elm_ui$Element$Input$TextInputNode = function (a) {
	return {$: 'TextInputNode', a: a};
};
var $mdgriffith$elm_ui$Element$Input$TextArea = {$: 'TextArea'};
var $mdgriffith$elm_ui$Internal$Model$LivePolite = {$: 'LivePolite'};
var $mdgriffith$elm_ui$Element$Region$announce = $mdgriffith$elm_ui$Internal$Model$Describe($mdgriffith$elm_ui$Internal$Model$LivePolite);
var $mdgriffith$elm_ui$Element$Input$applyLabel = F3(
	function (attrs, label, input) {
		if (label.$ === 'HiddenLabel') {
			var labelText = label.a;
			return A4(
				$mdgriffith$elm_ui$Internal$Model$element,
				$mdgriffith$elm_ui$Internal$Model$asColumn,
				$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
				attrs,
				$mdgriffith$elm_ui$Internal$Model$Unkeyed(
					_List_fromArray(
						[input])));
		} else {
			var position = label.a;
			var labelAttrs = label.b;
			var labelChild = label.c;
			var labelElement = A4(
				$mdgriffith$elm_ui$Internal$Model$element,
				$mdgriffith$elm_ui$Internal$Model$asEl,
				$mdgriffith$elm_ui$Internal$Model$div,
				labelAttrs,
				$mdgriffith$elm_ui$Internal$Model$Unkeyed(
					_List_fromArray(
						[labelChild])));
			switch (position.$) {
				case 'Above':
					return A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asColumn,
						$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
							attrs),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							_List_fromArray(
								[labelElement, input])));
				case 'Below':
					return A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asColumn,
						$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
							attrs),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							_List_fromArray(
								[input, labelElement])));
				case 'OnRight':
					return A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asRow,
						$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
							attrs),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							_List_fromArray(
								[input, labelElement])));
				default:
					return A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asRow,
						$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
							attrs),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							_List_fromArray(
								[labelElement, input])));
			}
		}
	});
var $mdgriffith$elm_ui$Element$Input$autofill = A2(
	$elm$core$Basics$composeL,
	$mdgriffith$elm_ui$Internal$Model$Attr,
	$elm$html$Html$Attributes$attribute('autocomplete'));
var $mdgriffith$elm_ui$Internal$Model$Behind = {$: 'Behind'};
var $mdgriffith$elm_ui$Element$behindContent = function (element) {
	return A2($mdgriffith$elm_ui$Element$createNearby, $mdgriffith$elm_ui$Internal$Model$Behind, element);
};
var $mdgriffith$elm_ui$Internal$Model$MoveY = function (a) {
	return {$: 'MoveY', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$moveY = $mdgriffith$elm_ui$Internal$Flag$flag(26);
var $mdgriffith$elm_ui$Element$moveUp = function (y) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$TransformComponent,
		$mdgriffith$elm_ui$Internal$Flag$moveY,
		$mdgriffith$elm_ui$Internal$Model$MoveY(-y));
};
var $mdgriffith$elm_ui$Element$Input$calcMoveToCompensateForPadding = function (attrs) {
	var gatherSpacing = F2(
		function (attr, found) {
			if ((attr.$ === 'StyleClass') && (attr.b.$ === 'SpacingStyle')) {
				var _v2 = attr.b;
				var x = _v2.b;
				var y = _v2.c;
				if (found.$ === 'Nothing') {
					return $elm$core$Maybe$Just(y);
				} else {
					return found;
				}
			} else {
				return found;
			}
		});
	var _v0 = A3($elm$core$List$foldr, gatherSpacing, $elm$core$Maybe$Nothing, attrs);
	if (_v0.$ === 'Nothing') {
		return $mdgriffith$elm_ui$Internal$Model$NoAttribute;
	} else {
		var vSpace = _v0.a;
		return $mdgriffith$elm_ui$Element$moveUp(
			$elm$core$Basics$floor(vSpace / 2));
	}
};
var $mdgriffith$elm_ui$Internal$Flag$borderColor = $mdgriffith$elm_ui$Internal$Flag$flag(28);
var $mdgriffith$elm_ui$Element$Border$color = function (clr) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$borderColor,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Colored,
			'bc-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(clr),
			'border-color',
			clr));
};
var $mdgriffith$elm_ui$Element$Input$darkGrey = A3($mdgriffith$elm_ui$Element$rgb, 186 / 255, 189 / 255, 182 / 255);
var $mdgriffith$elm_ui$Element$Input$defaultTextPadding = A2($mdgriffith$elm_ui$Element$paddingXY, 12, 12);
var $mdgriffith$elm_ui$Element$Input$white = A3($mdgriffith$elm_ui$Element$rgb, 1, 1, 1);
var $mdgriffith$elm_ui$Internal$Model$BorderWidth = F5(
	function (a, b, c, d, e) {
		return {$: 'BorderWidth', a: a, b: b, c: c, d: d, e: e};
	});
var $mdgriffith$elm_ui$Element$Border$width = function (v) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$borderWidth,
		A5(
			$mdgriffith$elm_ui$Internal$Model$BorderWidth,
			'b-' + $elm$core$String$fromInt(v),
			v,
			v,
			v,
			v));
};
var $mdgriffith$elm_ui$Element$Input$defaultTextBoxStyle = _List_fromArray(
	[
		$mdgriffith$elm_ui$Element$Input$defaultTextPadding,
		$mdgriffith$elm_ui$Element$Border$rounded(3),
		$mdgriffith$elm_ui$Element$Border$color($mdgriffith$elm_ui$Element$Input$darkGrey),
		$mdgriffith$elm_ui$Element$Background$color($mdgriffith$elm_ui$Element$Input$white),
		$mdgriffith$elm_ui$Element$Border$width(1),
		$mdgriffith$elm_ui$Element$spacing(5),
		$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
		$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink)
	]);
var $mdgriffith$elm_ui$Element$Input$getHeight = function (attr) {
	if (attr.$ === 'Height') {
		var h = attr.a;
		return $elm$core$Maybe$Just(h);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $mdgriffith$elm_ui$Internal$Model$Label = function (a) {
	return {$: 'Label', a: a};
};
var $mdgriffith$elm_ui$Element$Input$hiddenLabelAttribute = function (label) {
	if (label.$ === 'HiddenLabel') {
		var textLabel = label.a;
		return $mdgriffith$elm_ui$Internal$Model$Describe(
			$mdgriffith$elm_ui$Internal$Model$Label(textLabel));
	} else {
		return $mdgriffith$elm_ui$Internal$Model$NoAttribute;
	}
};
var $mdgriffith$elm_ui$Element$Input$isConstrained = function (len) {
	isConstrained:
	while (true) {
		switch (len.$) {
			case 'Content':
				return false;
			case 'Px':
				return true;
			case 'Fill':
				return true;
			case 'Min':
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isConstrained;
			default:
				var l = len.b;
				return true;
		}
	}
};
var $mdgriffith$elm_ui$Element$Input$isHiddenLabel = function (label) {
	if (label.$ === 'HiddenLabel') {
		return true;
	} else {
		return false;
	}
};
var $mdgriffith$elm_ui$Element$Input$isStacked = function (label) {
	if (label.$ === 'Label') {
		var loc = label.a;
		switch (loc.$) {
			case 'OnRight':
				return false;
			case 'OnLeft':
				return false;
			case 'Above':
				return true;
			default:
				return true;
		}
	} else {
		return true;
	}
};
var $mdgriffith$elm_ui$Element$Input$negateBox = function (box) {
	return {bottom: -box.bottom, left: -box.left, right: -box.right, top: -box.top};
};
var $mdgriffith$elm_ui$Element$Input$isFill = function (len) {
	isFill:
	while (true) {
		switch (len.$) {
			case 'Fill':
				return true;
			case 'Content':
				return false;
			case 'Px':
				return false;
			case 'Min':
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isFill;
			default:
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isFill;
		}
	}
};
var $mdgriffith$elm_ui$Element$Input$isPixel = function (len) {
	isPixel:
	while (true) {
		switch (len.$) {
			case 'Content':
				return false;
			case 'Px':
				return true;
			case 'Fill':
				return false;
			case 'Min':
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isPixel;
			default:
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isPixel;
		}
	}
};
var $mdgriffith$elm_ui$Element$Input$redistributeOver = F4(
	function (isMultiline, stacked, attr, els) {
		switch (attr.$) {
			case 'Nearby':
				return _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					});
			case 'Width':
				var width = attr.a;
				return $mdgriffith$elm_ui$Element$Input$isFill(width) ? _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent),
						input: A2($elm$core$List$cons, attr, els.input),
						parent: A2($elm$core$List$cons, attr, els.parent)
					}) : (stacked ? _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent)
					}) : _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					}));
			case 'Height':
				var height = attr.a;
				return (!stacked) ? _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent),
						parent: A2($elm$core$List$cons, attr, els.parent)
					}) : ($mdgriffith$elm_ui$Element$Input$isFill(height) ? _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent),
						parent: A2($elm$core$List$cons, attr, els.parent)
					}) : ($mdgriffith$elm_ui$Element$Input$isPixel(height) ? _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					}) : _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					})));
			case 'AlignX':
				return _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent)
					});
			case 'AlignY':
				return _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent)
					});
			case 'StyleClass':
				switch (attr.b.$) {
					case 'SpacingStyle':
						var _v1 = attr.b;
						return _Utils_update(
							els,
							{
								fullParent: A2($elm$core$List$cons, attr, els.fullParent),
								input: A2($elm$core$List$cons, attr, els.input),
								parent: A2($elm$core$List$cons, attr, els.parent),
								wrapper: A2($elm$core$List$cons, attr, els.wrapper)
							});
					case 'PaddingStyle':
						var cls = attr.a;
						var _v2 = attr.b;
						var pad = _v2.a;
						var t = _v2.b;
						var r = _v2.c;
						var b = _v2.d;
						var l = _v2.e;
						if (isMultiline) {
							return _Utils_update(
								els,
								{
									cover: A2($elm$core$List$cons, attr, els.cover),
									parent: A2($elm$core$List$cons, attr, els.parent)
								});
						} else {
							var newTop = t - A2($elm$core$Basics$min, t, b);
							var newLineHeight = $mdgriffith$elm_ui$Element$htmlAttribute(
								A2(
									$elm$html$Html$Attributes$style,
									'line-height',
									'calc(1.0em + ' + ($elm$core$String$fromFloat(
										2 * A2($elm$core$Basics$min, t, b)) + 'px)')));
							var newHeight = $mdgriffith$elm_ui$Element$htmlAttribute(
								A2(
									$elm$html$Html$Attributes$style,
									'height',
									'calc(1.0em + ' + ($elm$core$String$fromFloat(
										2 * A2($elm$core$Basics$min, t, b)) + 'px)')));
							var newBottom = b - A2($elm$core$Basics$min, t, b);
							var reducedVerticalPadding = A2(
								$mdgriffith$elm_ui$Internal$Model$StyleClass,
								$mdgriffith$elm_ui$Internal$Flag$padding,
								A5(
									$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
									A4($mdgriffith$elm_ui$Internal$Model$paddingNameFloat, newTop, r, newBottom, l),
									newTop,
									r,
									newBottom,
									l));
							return _Utils_update(
								els,
								{
									cover: A2($elm$core$List$cons, attr, els.cover),
									input: A2(
										$elm$core$List$cons,
										newHeight,
										A2($elm$core$List$cons, newLineHeight, els.input)),
									parent: A2($elm$core$List$cons, reducedVerticalPadding, els.parent)
								});
						}
					case 'BorderWidth':
						var _v3 = attr.b;
						return _Utils_update(
							els,
							{
								cover: A2($elm$core$List$cons, attr, els.cover),
								parent: A2($elm$core$List$cons, attr, els.parent)
							});
					case 'Transform':
						return _Utils_update(
							els,
							{
								cover: A2($elm$core$List$cons, attr, els.cover),
								parent: A2($elm$core$List$cons, attr, els.parent)
							});
					case 'FontSize':
						return _Utils_update(
							els,
							{
								fullParent: A2($elm$core$List$cons, attr, els.fullParent)
							});
					case 'FontFamily':
						var _v4 = attr.b;
						return _Utils_update(
							els,
							{
								fullParent: A2($elm$core$List$cons, attr, els.fullParent)
							});
					default:
						var flag = attr.a;
						var cls = attr.b;
						return _Utils_update(
							els,
							{
								parent: A2($elm$core$List$cons, attr, els.parent)
							});
				}
			case 'NoAttribute':
				return els;
			case 'Attr':
				var a = attr.a;
				return _Utils_update(
					els,
					{
						input: A2($elm$core$List$cons, attr, els.input)
					});
			case 'Describe':
				return _Utils_update(
					els,
					{
						input: A2($elm$core$List$cons, attr, els.input)
					});
			case 'Class':
				return _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					});
			default:
				return _Utils_update(
					els,
					{
						input: A2($elm$core$List$cons, attr, els.input)
					});
		}
	});
var $mdgriffith$elm_ui$Element$Input$redistribute = F3(
	function (isMultiline, stacked, attrs) {
		return function (redist) {
			return {
				cover: $elm$core$List$reverse(redist.cover),
				fullParent: $elm$core$List$reverse(redist.fullParent),
				input: $elm$core$List$reverse(redist.input),
				parent: $elm$core$List$reverse(redist.parent),
				wrapper: $elm$core$List$reverse(redist.wrapper)
			};
		}(
			A3(
				$elm$core$List$foldl,
				A2($mdgriffith$elm_ui$Element$Input$redistributeOver, isMultiline, stacked),
				{cover: _List_Nil, fullParent: _List_Nil, input: _List_Nil, parent: _List_Nil, wrapper: _List_Nil},
				attrs));
	});
var $mdgriffith$elm_ui$Element$Input$renderBox = function (_v0) {
	var top = _v0.top;
	var right = _v0.right;
	var bottom = _v0.bottom;
	var left = _v0.left;
	return $elm$core$String$fromInt(top) + ('px ' + ($elm$core$String$fromInt(right) + ('px ' + ($elm$core$String$fromInt(bottom) + ('px ' + ($elm$core$String$fromInt(left) + 'px'))))));
};
var $mdgriffith$elm_ui$Internal$Model$Transparency = F2(
	function (a, b) {
		return {$: 'Transparency', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Flag$transparency = $mdgriffith$elm_ui$Internal$Flag$flag(0);
var $mdgriffith$elm_ui$Element$alpha = function (o) {
	var transparency = function (x) {
		return 1 - x;
	}(
		A2(
			$elm$core$Basics$min,
			1.0,
			A2($elm$core$Basics$max, 0.0, o)));
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$transparency,
		A2(
			$mdgriffith$elm_ui$Internal$Model$Transparency,
			'transparency-' + $mdgriffith$elm_ui$Internal$Model$floatClass(transparency),
			transparency));
};
var $mdgriffith$elm_ui$Element$Input$charcoal = A3($mdgriffith$elm_ui$Element$rgb, 136 / 255, 138 / 255, 133 / 255);
var $mdgriffith$elm_ui$Element$rgba = $mdgriffith$elm_ui$Internal$Model$Rgba;
var $mdgriffith$elm_ui$Element$Input$renderPlaceholder = F3(
	function (_v0, forPlaceholder, on) {
		var placeholderAttrs = _v0.a;
		var placeholderEl = _v0.b;
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				forPlaceholder,
				_Utils_ap(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Font$color($mdgriffith$elm_ui$Element$Input$charcoal),
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.noTextSelection + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.passPointerEvents)),
							$mdgriffith$elm_ui$Element$clip,
							$mdgriffith$elm_ui$Element$Border$color(
							A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0)),
							$mdgriffith$elm_ui$Element$Background$color(
							A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0)),
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$alpha(
							on ? 1 : 0)
						]),
					placeholderAttrs)),
			placeholderEl);
	});
var $mdgriffith$elm_ui$Element$scrollbarY = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$overflow, $mdgriffith$elm_ui$Internal$Style$classes.scrollbarsY);
var $elm$html$Html$Attributes$spellcheck = $elm$html$Html$Attributes$boolProperty('spellcheck');
var $mdgriffith$elm_ui$Element$Input$spellcheck = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Attributes$spellcheck);
var $mdgriffith$elm_ui$Element$Input$value = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Attributes$value);
var $mdgriffith$elm_ui$Element$Input$textHelper = F3(
	function (textInput, attrs, textOptions) {
		var withDefaults = _Utils_ap($mdgriffith$elm_ui$Element$Input$defaultTextBoxStyle, attrs);
		var redistributed = A3(
			$mdgriffith$elm_ui$Element$Input$redistribute,
			_Utils_eq(textInput.type_, $mdgriffith$elm_ui$Element$Input$TextArea),
			$mdgriffith$elm_ui$Element$Input$isStacked(textOptions.label),
			withDefaults);
		var onlySpacing = function (attr) {
			if ((attr.$ === 'StyleClass') && (attr.b.$ === 'SpacingStyle')) {
				var _v9 = attr.b;
				return true;
			} else {
				return false;
			}
		};
		var heightConstrained = function () {
			var _v7 = textInput.type_;
			if (_v7.$ === 'TextInputNode') {
				var inputType = _v7.a;
				return false;
			} else {
				return A2(
					$elm$core$Maybe$withDefault,
					false,
					A2(
						$elm$core$Maybe$map,
						$mdgriffith$elm_ui$Element$Input$isConstrained,
						$elm$core$List$head(
							$elm$core$List$reverse(
								A2($elm$core$List$filterMap, $mdgriffith$elm_ui$Element$Input$getHeight, withDefaults)))));
			}
		}();
		var getPadding = function (attr) {
			if ((attr.$ === 'StyleClass') && (attr.b.$ === 'PaddingStyle')) {
				var cls = attr.a;
				var _v6 = attr.b;
				var pad = _v6.a;
				var t = _v6.b;
				var r = _v6.c;
				var b = _v6.d;
				var l = _v6.e;
				return $elm$core$Maybe$Just(
					{
						bottom: A2(
							$elm$core$Basics$max,
							0,
							$elm$core$Basics$floor(b - 3)),
						left: A2(
							$elm$core$Basics$max,
							0,
							$elm$core$Basics$floor(l - 3)),
						right: A2(
							$elm$core$Basics$max,
							0,
							$elm$core$Basics$floor(r - 3)),
						top: A2(
							$elm$core$Basics$max,
							0,
							$elm$core$Basics$floor(t - 3))
					});
			} else {
				return $elm$core$Maybe$Nothing;
			}
		};
		var parentPadding = A2(
			$elm$core$Maybe$withDefault,
			{bottom: 0, left: 0, right: 0, top: 0},
			$elm$core$List$head(
				$elm$core$List$reverse(
					A2($elm$core$List$filterMap, getPadding, withDefaults))));
		var inputElement = A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			function () {
				var _v3 = textInput.type_;
				if (_v3.$ === 'TextInputNode') {
					var inputType = _v3.a;
					return $mdgriffith$elm_ui$Internal$Model$NodeName('input');
				} else {
					return $mdgriffith$elm_ui$Internal$Model$NodeName('textarea');
				}
			}(),
			_Utils_ap(
				function () {
					var _v4 = textInput.type_;
					if (_v4.$ === 'TextInputNode') {
						var inputType = _v4.a;
						return _List_fromArray(
							[
								$mdgriffith$elm_ui$Internal$Model$Attr(
								$elm$html$Html$Attributes$type_(inputType)),
								$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputText)
							]);
					} else {
						return _List_fromArray(
							[
								$mdgriffith$elm_ui$Element$clip,
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputMultiline),
								$mdgriffith$elm_ui$Element$Input$calcMoveToCompensateForPadding(withDefaults),
								$mdgriffith$elm_ui$Element$paddingEach(parentPadding),
								$mdgriffith$elm_ui$Internal$Model$Attr(
								A2(
									$elm$html$Html$Attributes$style,
									'margin',
									$mdgriffith$elm_ui$Element$Input$renderBox(
										$mdgriffith$elm_ui$Element$Input$negateBox(parentPadding)))),
								$mdgriffith$elm_ui$Internal$Model$Attr(
								A2($elm$html$Html$Attributes$style, 'box-sizing', 'content-box'))
							]);
					}
				}(),
				_Utils_ap(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Input$value(textOptions.text),
							$mdgriffith$elm_ui$Internal$Model$Attr(
							$elm$html$Html$Events$onInput(textOptions.onChange)),
							$mdgriffith$elm_ui$Element$Input$hiddenLabelAttribute(textOptions.label),
							$mdgriffith$elm_ui$Element$Input$spellcheck(textInput.spellchecked),
							A2(
							$elm$core$Maybe$withDefault,
							$mdgriffith$elm_ui$Internal$Model$NoAttribute,
							A2($elm$core$Maybe$map, $mdgriffith$elm_ui$Element$Input$autofill, textInput.autofill))
						]),
					redistributed.input)),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(_List_Nil));
		var wrappedInput = function () {
			var _v0 = textInput.type_;
			if (_v0.$ === 'TextArea') {
				return A4(
					$mdgriffith$elm_ui$Internal$Model$element,
					$mdgriffith$elm_ui$Internal$Model$asEl,
					$mdgriffith$elm_ui$Internal$Model$div,
					_Utils_ap(
						(heightConstrained ? $elm$core$List$cons($mdgriffith$elm_ui$Element$scrollbarY) : $elm$core$Basics$identity)(
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
									A2($elm$core$List$any, $mdgriffith$elm_ui$Element$Input$hasFocusStyle, withDefaults) ? $mdgriffith$elm_ui$Internal$Model$NoAttribute : $mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.focusedWithin),
									$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineWrapper)
								])),
						redistributed.parent),
					$mdgriffith$elm_ui$Internal$Model$Unkeyed(
						_List_fromArray(
							[
								A4(
								$mdgriffith$elm_ui$Internal$Model$element,
								$mdgriffith$elm_ui$Internal$Model$asParagraph,
								$mdgriffith$elm_ui$Internal$Model$div,
								A2(
									$elm$core$List$cons,
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
									A2(
										$elm$core$List$cons,
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										A2(
											$elm$core$List$cons,
											$mdgriffith$elm_ui$Element$inFront(inputElement),
											A2(
												$elm$core$List$cons,
												$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineParent),
												redistributed.wrapper)))),
								$mdgriffith$elm_ui$Internal$Model$Unkeyed(
									function () {
										if (textOptions.text === '') {
											var _v1 = textOptions.placeholder;
											if (_v1.$ === 'Nothing') {
												return _List_fromArray(
													[
														$mdgriffith$elm_ui$Element$text('\u00A0')
													]);
											} else {
												var place = _v1.a;
												return _List_fromArray(
													[
														A3($mdgriffith$elm_ui$Element$Input$renderPlaceholder, place, _List_Nil, textOptions.text === '')
													]);
											}
										} else {
											return _List_fromArray(
												[
													$mdgriffith$elm_ui$Internal$Model$unstyled(
													A2(
														$elm$html$Html$span,
														_List_fromArray(
															[
																$elm$html$Html$Attributes$class($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineFiller)
															]),
														_List_fromArray(
															[
																$elm$html$Html$text(textOptions.text + '\u00A0')
															])))
												]);
										}
									}()))
							])));
			} else {
				var inputType = _v0.a;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$element,
					$mdgriffith$elm_ui$Internal$Model$asEl,
					$mdgriffith$elm_ui$Internal$Model$div,
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						A2(
							$elm$core$List$cons,
							A2($elm$core$List$any, $mdgriffith$elm_ui$Element$Input$hasFocusStyle, withDefaults) ? $mdgriffith$elm_ui$Internal$Model$NoAttribute : $mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.focusedWithin),
							$elm$core$List$concat(
								_List_fromArray(
									[
										redistributed.parent,
										function () {
										var _v2 = textOptions.placeholder;
										if (_v2.$ === 'Nothing') {
											return _List_Nil;
										} else {
											var place = _v2.a;
											return _List_fromArray(
												[
													$mdgriffith$elm_ui$Element$behindContent(
													A3($mdgriffith$elm_ui$Element$Input$renderPlaceholder, place, redistributed.cover, textOptions.text === ''))
												]);
										}
									}()
									])))),
					$mdgriffith$elm_ui$Internal$Model$Unkeyed(
						_List_fromArray(
							[inputElement])));
			}
		}();
		return A3(
			$mdgriffith$elm_ui$Element$Input$applyLabel,
			A2(
				$elm$core$List$cons,
				A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$cursor, $mdgriffith$elm_ui$Internal$Style$classes.cursorText),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$Input$isHiddenLabel(textOptions.label) ? $mdgriffith$elm_ui$Internal$Model$NoAttribute : $mdgriffith$elm_ui$Element$spacing(5),
					A2($elm$core$List$cons, $mdgriffith$elm_ui$Element$Region$announce, redistributed.fullParent))),
			textOptions.label,
			wrappedInput);
	});
var $mdgriffith$elm_ui$Element$Input$text = $mdgriffith$elm_ui$Element$Input$textHelper(
	{
		autofill: $elm$core$Maybe$Nothing,
		spellchecked: false,
		type_: $mdgriffith$elm_ui$Element$Input$TextInputNode('text')
	});
var $author$project$Components$DialogView$textInputBody = F2(
	function (playlistName, textChangeMsg) {
		return A2(
			$mdgriffith$elm_ui$Element$column,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
				]),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$Input$text,
					_List_fromArray(
						[$mdgriffith$elm_ui$Element$centerX]),
					{
						label: A2(
							$mdgriffith$elm_ui$Element$Input$labelAbove,
							_List_Nil,
							$mdgriffith$elm_ui$Element$text('Playlist name: ')),
						onChange: textChangeMsg,
						placeholder: $elm$core$Maybe$Nothing,
						text: playlistName
					})
				]));
	});
var $author$project$Components$DialogView$textInputFooterButtons = function (closeDialogMsg) {
	return A2(
		$mdgriffith$elm_ui$Element$row,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$padding(2),
				$mdgriffith$elm_ui$Element$spacing(5)
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$Input$button,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$cerulean),
						$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$white),
						$mdgriffith$elm_ui$Element$Font$bold,
						$mdgriffith$elm_ui$Element$Border$rounded(3),
						A2($mdgriffith$elm_ui$Element$paddingXY, 30, 12),
						$mdgriffith$elm_ui$Element$centerX,
						$mdgriffith$elm_ui$Element$mouseOver(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$cerulean),
								$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$grey)
							]))
					]),
				{
					label: $mdgriffith$elm_ui$Element$text('OK'),
					onPress: $elm$core$Maybe$Just(closeDialogMsg)
				})
			]));
};
var $author$project$Components$DialogView$textInputConfig = F3(
	function (playlistName, closeDialogMsg, textChangeMsg) {
		return {
			body: $elm$core$Maybe$Just(
				A2($author$project$Components$DialogView$textInputBody, playlistName, textChangeMsg)),
			bodyAttributes: _List_fromArray(
				[
					$mdgriffith$elm_ui$Element$padding(20),
					$mdgriffith$elm_ui$Element$Font$size(24),
					$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$grey)
				]),
			closeMessage: $elm$core$Maybe$Just(closeDialogMsg),
			containerAttributes: _List_fromArray(
				[
					$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$white),
					$mdgriffith$elm_ui$Element$Border$rounded(5),
					$mdgriffith$elm_ui$Element$centerX,
					$mdgriffith$elm_ui$Element$centerY,
					$mdgriffith$elm_ui$Element$padding(10),
					$mdgriffith$elm_ui$Element$spacing(20),
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(400))
				]),
			footer: $elm$core$Maybe$Just(
				$author$project$Components$DialogView$textInputFooterButtons(closeDialogMsg)),
			footerAttributes: _List_Nil,
			header: $elm$core$Maybe$Just(
				$mdgriffith$elm_ui$Element$text('')),
			headerAttributes: _List_fromArray(
				[
					$mdgriffith$elm_ui$Element$Font$size(24),
					$mdgriffith$elm_ui$Element$Font$color($author$project$Colors$red),
					$mdgriffith$elm_ui$Element$padding(5)
				]),
			maskAttributes: _List_Nil
		};
	});
var $author$project$Colors$headerBackground = A3($mdgriffith$elm_ui$Element$rgb255, 30, 33, 34);
var $mdgriffith$elm_ui$Element$Input$HiddenLabel = function (a) {
	return {$: 'HiddenLabel', a: a};
};
var $mdgriffith$elm_ui$Element$Input$labelHidden = $mdgriffith$elm_ui$Element$Input$HiddenLabel;
var $mdgriffith$elm_ui$Element$Input$Placeholder = F2(
	function (a, b) {
		return {$: 'Placeholder', a: a, b: b};
	});
var $mdgriffith$elm_ui$Element$Input$placeholder = $mdgriffith$elm_ui$Element$Input$Placeholder;
var $mdgriffith$elm_ui$Element$Input$search = $mdgriffith$elm_ui$Element$Input$textHelper(
	{
		autofill: $elm$core$Maybe$Nothing,
		spellchecked: false,
		type_: $mdgriffith$elm_ui$Element$Input$TextInputNode('search')
	});
var $author$project$Components$Header$view = function (searchChanged) {
	return A2(
		$mdgriffith$elm_ui$Element$row,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$height(
				$mdgriffith$elm_ui$Element$px($author$project$Components$Header$headerHeight)),
				$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$headerBackground),
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'pointer-events', 'all'))
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$link,
				_List_Nil,
				{
					label: A2(
						$mdgriffith$elm_ui$Element$image,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$px(37)),
								$mdgriffith$elm_ui$Element$height(
								$mdgriffith$elm_ui$Element$px(37)),
								A2($mdgriffith$elm_ui$Element$paddingXY, 7, 0)
							]),
						{description: '', src: 'https://raw.githubusercontent.com/ionif/elm-chorus/master/logo.png'}),
					url: $author$project$Spa$Generated$Route$toString($author$project$Spa$Generated$Route$Top)
				}),
				A2(
				$mdgriffith$elm_ui$Element$Input$search,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alignRight,
						$mdgriffith$elm_ui$Element$width(
						$mdgriffith$elm_ui$Element$px(200)),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
					]),
				{
					label: $mdgriffith$elm_ui$Element$Input$labelHidden('Search'),
					onChange: searchChanged,
					placeholder: $elm$core$Maybe$Just(
						A2(
							$mdgriffith$elm_ui$Element$Input$placeholder,
							_List_Nil,
							$mdgriffith$elm_ui$Element$text('Search'))),
					text: ''
				})
			]));
};
var $icidasset$elm_material_icons$Material$Icons$extension = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M20.5 11H19V7c0-1.1-.9-2-2-2h-4V3.5C13 2.12 11.88 1 10.5 1S8 2.12 8 3.5V5H4c-1.1 0-1.99.9-1.99 2v3.8H3.5c1.49 0 2.7 1.21 2.7 2.7s-1.21 2.7-2.7 2.7H2V20c0 1.1.9 2 2 2h3.8v-1.5c0-1.49 1.21-2.7 2.7-2.7 1.49 0 2.7 1.21 2.7 2.7V22H17c1.1 0 2-.9 2-2v-4h1.5c1.38 0 2.5-1.12 2.5-2.5S21.88 11 20.5 11z')
				]),
			_List_Nil)
		]));
var $mdgriffith$elm_ui$Internal$Model$Scale = function (a) {
	return {$: 'Scale', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$scale = $mdgriffith$elm_ui$Internal$Flag$flag(23);
var $mdgriffith$elm_ui$Element$scale = function (n) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$TransformComponent,
		$mdgriffith$elm_ui$Internal$Flag$scale,
		$mdgriffith$elm_ui$Internal$Model$Scale(
			_Utils_Tuple3(n, n, 1)));
};
var $author$project$Components$LeftSidebar$materialIconLink = function (_v0) {
	var icon = _v0.a;
	var route = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$el,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$mouseOver(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$scale(1.1),
						$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$brandPrimary)
					]))
			]),
		A2(
			$mdgriffith$elm_ui$Element$link,
			_List_Nil,
			{
				label: $mdgriffith$elm_ui$Element$html(
					A2(
						icon,
						20,
						$icidasset$elm_material_icons$Material$Icons$Types$Color(
							$author$project$Colors$fromElementColorToColor($author$project$Colors$greyscaleOuterSpace)))),
				url: $author$project$Spa$Generated$Route$toString(route)
			}));
};
var $author$project$Components$LeftSidebar$addonsButton = $author$project$Components$LeftSidebar$materialIconLink(
	_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$extension, $author$project$Spa$Generated$Route$Addons));
var $mdgriffith$elm_ui$Internal$Model$Left = {$: 'Left'};
var $mdgriffith$elm_ui$Element$alignLeft = $mdgriffith$elm_ui$Internal$Model$AlignX($mdgriffith$elm_ui$Internal$Model$Left);
var $icidasset$elm_material_icons$Material$Icons$list = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M3 13h2v-2H3v2zm0 4h2v-2H3v2zm0-8h2V7H3v2zm4 4h14v-2H7v2zm0 4h14v-2H7v2zM7 7v2h14V7H7z')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil)
		]));
var $author$project$Components$LeftSidebar$browserButton = $author$project$Components$LeftSidebar$materialIconLink(
	_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$list, $author$project$Spa$Generated$Route$Browser));
var $icidasset$elm_material_icons$Material$Icons$help = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 17h-2v-2h2v2zm2.07-7.75l-.9.92C13.45 12.9 13 13.5 13 15h-2v-.5c0-1.1.45-2.1 1.17-2.83l1.24-1.26c.37-.36.59-.86.59-1.41 0-1.1-.9-2-2-2s-2 .9-2 2H8c0-2.21 1.79-4 4-4s4 1.79 4 4c0 .88-.36 1.68-.93 2.25z')
				]),
			_List_Nil)
		]));
var $author$project$Components$LeftSidebar$helpButton = $author$project$Components$LeftSidebar$materialIconLink(
	_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$help, $author$project$Spa$Generated$Route$Help));
var $icidasset$elm_material_icons$Material$Icons$movie = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M18 4l2 4h-3l-2-4h-2l2 4h-3l-2-4H8l2 4H7L5 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V4h-4z')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil)
		]));
var $author$project$Components$LeftSidebar$movieButton = $author$project$Components$LeftSidebar$materialIconLink(
	_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$movie, $author$project$Spa$Generated$Route$Movies__Recent));
var $icidasset$elm_material_icons$Material$Icons$library_music = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M20 2H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-2 5h-3v5.5c0 1.38-1.12 2.5-2.5 2.5S10 13.88 10 12.5s1.12-2.5 2.5-2.5c.57 0 1.08.19 1.5.51V5h4v2zM4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6z')
				]),
			_List_Nil)
		]));
var $author$project$Components$LeftSidebar$musicButton = $author$project$Components$LeftSidebar$materialIconLink(
	_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$library_music, $author$project$Spa$Generated$Route$Music));
var $icidasset$elm_material_icons$Material$Icons$assignment = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M19 3h-4.18C14.4 1.84 13.3 1 12 1c-1.3 0-2.4.84-2.82 2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-7 0c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zm2 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z')
				]),
			_List_Nil)
		]));
var $author$project$Components$LeftSidebar$playlistButton = $author$project$Components$LeftSidebar$materialIconLink(
	_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$assignment, $author$project$Spa$Generated$Route$Playlists));
var $elm$svg$Svg$Attributes$enableBackground = _VirtualDom_attribute('enable-background');
var $icidasset$elm_material_icons$Material$Icons$settings = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$enableBackground('new 0 0 24 24'),
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$g,
			_List_Nil,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$d('M0,0h24v24H0V0z'),
							$elm$svg$Svg$Attributes$fill('none')
						]),
					_List_Nil),
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$d('M19.14,12.94c0.04-0.3,0.06-0.61,0.06-0.94c0-0.32-0.02-0.64-0.07-0.94l2.03-1.58c0.18-0.14,0.23-0.41,0.12-0.61 l-1.92-3.32c-0.12-0.22-0.37-0.29-0.59-0.22l-2.39,0.96c-0.5-0.38-1.03-0.7-1.62-0.94L14.4,2.81c-0.04-0.24-0.24-0.41-0.48-0.41 h-3.84c-0.24,0-0.43,0.17-0.47,0.41L9.25,5.35C8.66,5.59,8.12,5.92,7.63,6.29L5.24,5.33c-0.22-0.08-0.47,0-0.59,0.22L2.74,8.87 C2.62,9.08,2.66,9.34,2.86,9.48l2.03,1.58C4.84,11.36,4.8,11.69,4.8,12s0.02,0.64,0.07,0.94l-2.03,1.58 c-0.18,0.14-0.23,0.41-0.12,0.61l1.92,3.32c0.12,0.22,0.37,0.29,0.59,0.22l2.39-0.96c0.5,0.38,1.03,0.7,1.62,0.94l0.36,2.54 c0.05,0.24,0.24,0.41,0.48,0.41h3.84c0.24,0,0.44-0.17,0.47-0.41l0.36-2.54c0.59-0.24,1.13-0.56,1.62-0.94l2.39,0.96 c0.22,0.08,0.47,0,0.59-0.22l1.92-3.32c0.12-0.22,0.07-0.47-0.12-0.61L19.14,12.94z M12,15.6c-1.98,0-3.6-1.62-3.6-3.6 s1.62-3.6,3.6-3.6s3.6,1.62,3.6,3.6S13.98,15.6,12,15.6z')
						]),
					_List_Nil)
				]))
		]));
var $author$project$Components$LeftSidebar$settingsButton = $author$project$Components$LeftSidebar$materialIconLink(
	_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$settings, $author$project$Spa$Generated$Route$Settings__Web));
var $author$project$Components$LeftSidebar$thumbsupButton = $author$project$Components$LeftSidebar$materialIconLink(
	_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$thumb_up, $author$project$Spa$Generated$Route$Thumbsup));
var $icidasset$elm_material_icons$Material$Icons$tv = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M21 3H3c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h5v2h8v-2h5c1.1 0 1.99-.9 1.99-2L23 5c0-1.1-.9-2-2-2zm0 14H3V5h18v12z')
				]),
			_List_Nil)
		]));
var $author$project$Components$LeftSidebar$tvshowButton = $author$project$Components$LeftSidebar$materialIconLink(
	_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$tv, $author$project$Spa$Generated$Route$Tvshows__Recent));
var $author$project$Components$LeftSidebar$view = A2(
	$mdgriffith$elm_ui$Element$column,
	_List_fromArray(
		[
			$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
			$mdgriffith$elm_ui$Element$centerX,
			$mdgriffith$elm_ui$Element$spacing(20),
			$mdgriffith$elm_ui$Element$padding(15),
			$mdgriffith$elm_ui$Element$alignLeft,
			$mdgriffith$elm_ui$Element$htmlAttribute(
			A2($elm$html$Html$Attributes$style, 'pointer-events', 'all'))
		]),
	_List_fromArray(
		[$author$project$Components$LeftSidebar$musicButton, $author$project$Components$LeftSidebar$movieButton, $author$project$Components$LeftSidebar$tvshowButton, $author$project$Components$LeftSidebar$browserButton, $author$project$Components$LeftSidebar$addonsButton, $author$project$Components$LeftSidebar$thumbsupButton, $author$project$Components$LeftSidebar$playlistButton, $author$project$Components$LeftSidebar$settingsButton, $author$project$Components$LeftSidebar$helpButton]));
var $author$project$Components$PlayerRow$currentlyPlayingColumn = function (_v0) {
	var currentlyPlaying = _v0.currentlyPlaying;
	var progressSlider = _v0.progressSlider;
	return A2(
		$mdgriffith$elm_ui$Element$column,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(20))
					]),
				_List_fromArray(
					[progressSlider])),
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(25)),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleOuterSpace),
						$mdgriffith$elm_ui$Element$alignBottom,
						$mdgriffith$elm_ui$Element$padding(8)
					]),
				function () {
					if (currentlyPlaying.$ === 'Nothing') {
						return _List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Element$el,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$Font$color(
										A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
										$mdgriffith$elm_ui$Element$Font$size(18)
									]),
								$mdgriffith$elm_ui$Element$text('Nothing playing')),
								A2(
								$mdgriffith$elm_ui$Element$el,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$alignRight,
										$mdgriffith$elm_ui$Element$Font$color(
										A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
										$mdgriffith$elm_ui$Element$Font$size(18)
									]),
								$mdgriffith$elm_ui$Element$text('0'))
							]);
					} else {
						var item = currentlyPlaying.a;
						return _List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Element$el,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$Font$color(
										A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
										$mdgriffith$elm_ui$Element$Font$size(18)
									]),
								$mdgriffith$elm_ui$Element$text(item.title)),
								A2(
								$mdgriffith$elm_ui$Element$el,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$alignRight,
										$mdgriffith$elm_ui$Element$Font$color(
										A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
										$mdgriffith$elm_ui$Element$Font$size(18)
									]),
								$mdgriffith$elm_ui$Element$text(
									$author$project$Helper$durationToString(item.duration)))
							]);
					}
				}()),
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(25)),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleOuterSpace),
						$mdgriffith$elm_ui$Element$alignBottom,
						$mdgriffith$elm_ui$Element$padding(8)
					]),
				function () {
					if (currentlyPlaying.$ === 'Nothing') {
						return _List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Element$el,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$Font$color(
										A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
										$mdgriffith$elm_ui$Element$Font$size(13)
									]),
								$mdgriffith$elm_ui$Element$text('Nothing playing'))
							]);
					} else {
						var item = currentlyPlaying.a;
						return A2(
							$elm$core$List$map,
							function (artist) {
								return A2(
									$mdgriffith$elm_ui$Element$el,
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$Font$color(
											A3($mdgriffith$elm_ui$Element$rgb, 0.6, 0.6, 0.6)),
											$mdgriffith$elm_ui$Element$Font$size(13)
										]),
									$mdgriffith$elm_ui$Element$text(artist));
							},
							item.artist);
					}
				}())
			]));
};
var $author$project$Colors$greyscaleShark = A3($mdgriffith$elm_ui$Element$rgb255, 49, 50, 51);
var $author$project$Components$PlayerRow$materialButtonBig = function (_v0) {
	var icon = _v0.a;
	var action = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_Nil,
		{
			label: $mdgriffith$elm_ui$Element$html(
				A2(
					icon,
					62,
					$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
			onPress: $elm$core$Maybe$Just(action)
		});
};
var $icidasset$elm_material_icons$Material$Icons$pause = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M6 19h4V5H6v14zm8-14v14h4V5h-4z')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil)
		]));
var $author$project$Components$PlayerRow$playButton = F2(
	function (playing, playPauseMsg) {
		if (!playing) {
			return $author$project$Components$PlayerRow$materialButtonBig(
				_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$play_arrow, playPauseMsg));
		} else {
			return $author$project$Components$PlayerRow$materialButtonBig(
				_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$pause, playPauseMsg));
		}
	});
var $icidasset$elm_material_icons$Material$Icons$skip_previous = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M6 6h2v12H6zm3.5 6l8.5 6V6z')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil)
		]));
var $author$project$Components$PlayerRow$reverseButton = function (reverseMsg) {
	return $author$project$Components$PlayerRow$materialButtonBig(
		_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$skip_previous, reverseMsg));
};
var $icidasset$elm_material_icons$Material$Icons$skip_next = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M6 18l8.5-6L6 6v12zM16 6v12h2V6h-2z')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil)
		]));
var $author$project$Components$PlayerRow$skipButton = function (skipMsg) {
	return $author$project$Components$PlayerRow$materialButtonBig(
		_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$skip_next, skipMsg));
};
var $mdgriffith$elm_ui$Element$spaceEvenly = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$spacing, $mdgriffith$elm_ui$Internal$Style$classes.spaceEvenly);
var $author$project$Components$PlayerRow$playControlRow = function (_v0) {
	var reverseMsg = _v0.reverseMsg;
	var playPauseMsg = _v0.playPauseMsg;
	var skipMsg = _v0.skipMsg;
	var playing = _v0.playing;
	return A2(
		$mdgriffith$elm_ui$Element$row,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$width(
				$mdgriffith$elm_ui$Element$px(300)),
				$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleShark),
				$mdgriffith$elm_ui$Element$alignBottom,
				$mdgriffith$elm_ui$Element$Font$center,
				$mdgriffith$elm_ui$Element$spaceEvenly
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$el,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$padding(10)
					]),
				$author$project$Components$PlayerRow$reverseButton(reverseMsg)),
				A2(
				$mdgriffith$elm_ui$Element$el,
				_List_Nil,
				A2($author$project$Components$PlayerRow$playButton, playing, playPauseMsg)),
				A2(
				$mdgriffith$elm_ui$Element$el,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$padding(10)
					]),
				$author$project$Components$PlayerRow$skipButton(skipMsg))
			]));
};
var $author$project$Components$PlayerRow$materialButton = function (_v0) {
	var icon = _v0.a;
	var action = _v0.b;
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$width(
				$mdgriffith$elm_ui$Element$px(75))
			]),
		{
			label: $mdgriffith$elm_ui$Element$html(
				A2(
					icon,
					32,
					$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
			onPress: $elm$core$Maybe$Just(action)
		});
};
var $author$project$Components$PlayerRow$controlButton = function (controlMenuMsg) {
	return $author$project$Components$PlayerRow$materialButton(
		_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$more_vert, controlMenuMsg));
};
var $mdgriffith$elm_ui$Internal$Model$Above = {$: 'Above'};
var $mdgriffith$elm_ui$Element$above = function (element) {
	return A2($mdgriffith$elm_ui$Element$createNearby, $mdgriffith$elm_ui$Internal$Model$Above, element);
};
var $mdgriffith$elm_ui$Element$fromRgb = function (clr) {
	return A4($mdgriffith$elm_ui$Internal$Model$Rgba, clr.red, clr.green, clr.blue, clr.alpha);
};
var $avh4$elm_color$Color$toRgba = function (_v0) {
	var r = _v0.a;
	var g = _v0.b;
	var b = _v0.c;
	var a = _v0.d;
	return {alpha: a, blue: b, green: g, red: r};
};
var $author$project$Colors$fromColorToElementColor = function (color) {
	return $mdgriffith$elm_ui$Element$fromRgb(
		$avh4$elm_color$Color$toRgba(color));
};
var $author$project$Colors$playerControl = $author$project$Colors$fromColorToElementColor($author$project$Colors$greyIcon);
var $author$project$Components$PlayerRow$controlMenuRow = F2(
	function (onPress, label) {
		return A2(
			$mdgriffith$elm_ui$Element$Input$button,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$mouseOver(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$playerControl)
						])),
					$mdgriffith$elm_ui$Element$padding(7)
				]),
			{
				label: $mdgriffith$elm_ui$Element$text(label),
				onPress: onPress
			});
	});
var $author$project$Components$PlayerRow$controlMenuDropUp = F4(
	function (controlMenu, sendTextToKodiMsg, scanVideoLibraryMsg, scanMusicLibraryMsg) {
		return controlMenu ? _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$above(
				A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$white)
						]),
					_List_fromArray(
						[
							A2(
							$author$project$Components$PlayerRow$controlMenuRow,
							$elm$core$Maybe$Just(scanVideoLibraryMsg),
							'Scan video library'),
							A2(
							$author$project$Components$PlayerRow$controlMenuRow,
							$elm$core$Maybe$Just(scanMusicLibraryMsg),
							'Scan audio library'),
							A2(
							$author$project$Components$PlayerRow$controlMenuRow,
							$elm$core$Maybe$Just(sendTextToKodiMsg),
							'Send text to Kodi'),
							A2(
							$mdgriffith$elm_ui$Element$link,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
								]),
							{
								label: A2($author$project$Components$PlayerRow$controlMenuRow, $elm$core$Maybe$Nothing, 'The lab'),
								url: $author$project$Spa$Generated$Route$toString($author$project$Spa$Generated$Route$Lab)
							}),
							A2(
							$mdgriffith$elm_ui$Element$link,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
								]),
							{
								label: A2($author$project$Components$PlayerRow$controlMenuRow, $elm$core$Maybe$Nothing, 'About Chorus'),
								url: $author$project$Spa$Generated$Route$toString($author$project$Spa$Generated$Route$Help)
							})
						])))
			]) : _List_Nil;
	});
var $icidasset$elm_material_icons$Material$Icons$repeat = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M7 7h10v3l4-4-4-4v3H5v6h2V7zm10 10H7v-3l-4 4 4 4v-3h12v-6h-2v4z')
				]),
			_List_Nil)
		]));
var $author$project$Components$PlayerRow$repeatButton = function (repeatMsg) {
	return $author$project$Components$PlayerRow$materialButton(
		_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$repeat, repeatMsg));
};
var $icidasset$elm_material_icons$Material$Icons$shuffle = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M10.59 9.17L5.41 4 4 5.41l5.17 5.17 1.42-1.41zM14.5 4l2.04 2.04L4 18.59 5.41 20 17.96 7.46 20 9.5V4h-5.5zm.33 9.41l-1.41 1.41 3.13 3.13L14.5 20H20v-5.5l-2.04 2.04-3.13-3.13z')
				]),
			_List_Nil)
		]));
var $author$project$Components$PlayerRow$shuffleButton = function (shuffleMsg) {
	return $author$project$Components$PlayerRow$materialButton(
		_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$shuffle, shuffleMsg));
};
var $icidasset$elm_material_icons$Material$Icons$volume_up = A2(
	$icidasset$elm_material_icons$Material$Icons$Internal$icon,
	_List_fromArray(
		[
			$elm$svg$Svg$Attributes$viewBox('0 0 24 24')
		]),
	_List_fromArray(
		[
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M3 9v6h4l5 5V4L7 9H3zm13.5 3c0-1.77-1.02-3.29-2.5-4.03v8.05c1.48-.73 2.5-2.25 2.5-4.02zM14 3.23v2.06c2.89.86 5 3.54 5 6.71s-2.11 5.85-5 6.71v2.06c4.01-.91 7-4.49 7-8.77s-2.99-7.86-7-8.77z')
				]),
			_List_Nil),
			A2(
			$elm$svg$Svg$path,
			_List_fromArray(
				[
					$elm$svg$Svg$Attributes$d('M0 0h24v24H0z'),
					$elm$svg$Svg$Attributes$fill('none')
				]),
			_List_Nil)
		]));
var $author$project$Components$PlayerRow$volumeButton = function (muteMsg) {
	return $author$project$Components$PlayerRow$materialButton(
		_Utils_Tuple2($icidasset$elm_material_icons$Material$Icons$volume_up, muteMsg));
};
var $author$project$Components$PlayerRow$volumesAndControlsColumn = F2(
	function (_v0, _v1) {
		var muteMsg = _v0.muteMsg;
		var repeatMsg = _v0.repeatMsg;
		var shuffleMsg = _v0.shuffleMsg;
		var volumeSlider = _v0.volumeSlider;
		var controlMenu = _v1.controlMenu;
		var controlMenuMsg = _v1.controlMenuMsg;
		var sendTextToKodiMsg = _v1.sendTextToKodiMsg;
		var scanVideoLibraryMsg = _v1.scanVideoLibraryMsg;
		var scanMusicLibraryMsg = _v1.scanMusicLibraryMsg;
		return A2(
			$mdgriffith$elm_ui$Element$column,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(300))
				]),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$row,
					_Utils_ap(
						A4($author$project$Components$PlayerRow$controlMenuDropUp, controlMenu, sendTextToKodiMsg, scanVideoLibraryMsg, scanMusicLibraryMsg),
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$height(
								$mdgriffith$elm_ui$Element$px(20))
							])),
					_List_fromArray(
						[volumeSlider])),
					A2(
					$mdgriffith$elm_ui$Element$row,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$greyscaleShark)
						]),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Element$el,
							_List_fromArray(
								[$mdgriffith$elm_ui$Element$centerX]),
							$author$project$Components$PlayerRow$volumeButton(muteMsg)),
							A2(
							$mdgriffith$elm_ui$Element$el,
							_List_fromArray(
								[$mdgriffith$elm_ui$Element$centerX]),
							$author$project$Components$PlayerRow$repeatButton(repeatMsg)),
							A2(
							$mdgriffith$elm_ui$Element$el,
							_List_fromArray(
								[$mdgriffith$elm_ui$Element$centerX]),
							$author$project$Components$PlayerRow$shuffleButton(shuffleMsg)),
							A2(
							$mdgriffith$elm_ui$Element$el,
							_List_fromArray(
								[$mdgriffith$elm_ui$Element$centerX]),
							$author$project$Components$PlayerRow$controlButton(controlMenuMsg))
						]))
				]));
	});
var $author$project$Components$PlayerRow$view = function (layoutType) {
	return A2(
		$mdgriffith$elm_ui$Element$row,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$height(
				$mdgriffith$elm_ui$Element$px($author$project$Components$PlayerRow$playerHeight)),
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$alignBottom,
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'pointer-events', 'all'))
			]),
		_List_fromArray(
			[
				$author$project$Components$PlayerRow$playControlRow(layoutType.playerControl),
				A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width(
						$mdgriffith$elm_ui$Element$px($author$project$Components$PlayerRow$playerHeight))
					]),
				_List_fromArray(
					[
						function () {
						var _v0 = layoutType.currentlyPlaying.currentlyPlaying;
						if (_v0.$ === 'Nothing') {
							return A2(
								$mdgriffith$elm_ui$Element$image,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$alignLeft,
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
									]),
								{description: 'Hero Image', src: 'https://via.placeholder.com/70'});
						} else {
							var item = _v0.a;
							return A2(
								$mdgriffith$elm_ui$Element$image,
								_List_fromArray(
									[
										$mdgriffith$elm_ui$Element$alignLeft,
										$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
									]),
								{
									description: 'Thumbnail',
									src: A3(
										$elm$url$Url$Builder$crossOrigin,
										'http://localhost:8080',
										_List_fromArray(
											[
												'image',
												$elm$url$Url$percentEncode(item.thumbnail)
											]),
										_List_Nil)
								});
						}
					}()
					])),
				$author$project$Components$PlayerRow$currentlyPlayingColumn(layoutType.currentlyPlaying),
				A2($author$project$Components$PlayerRow$volumesAndControlsColumn, layoutType.volumeAndControls, layoutType.controlMenu)
			]));
};
var $author$project$Colors$greyscaleDeepSpace = A3($mdgriffith$elm_ui$Element$rgb255, 27, 28, 29);
var $author$project$Colors$backgroundKodi = $author$project$Colors$greyscaleDeepSpace;
var $author$project$Colors$backgroundLocal = $author$project$Colors$greyscaleShark;
var $author$project$Colors$playlistBackground = $author$project$Colors$greyscaleDeepSpace;
var $author$project$Colors$playlistHeaderBackground = $author$project$Colors$greyscaleShark;
var $author$project$Components$RightSidebar$view = F4(
	function (rightSidebarExtended, rightSidebarMsg, panelHeight, connection) {
		return rightSidebarExtended ? A2(
			$mdgriffith$elm_ui$Element$column,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(panelHeight)),
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(400)),
					$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$playlistHeaderBackground),
					$mdgriffith$elm_ui$Element$alignRight,
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'pointer-events', 'all'))
				]),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$row,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
						]),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Element$Input$button,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$backgroundKodi),
									$mdgriffith$elm_ui$Element$height(
									$mdgriffith$elm_ui$Element$px(50)),
									$mdgriffith$elm_ui$Element$width(
									$mdgriffith$elm_ui$Element$px(100)),
									$mdgriffith$elm_ui$Element$padding(8)
								]),
							{
								label: $mdgriffith$elm_ui$Element$text('Kodi'),
								onPress: $elm$core$Maybe$Just(rightSidebarMsg)
							}),
							A2(
							$mdgriffith$elm_ui$Element$Input$button,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$backgroundLocal),
									$mdgriffith$elm_ui$Element$height(
									$mdgriffith$elm_ui$Element$px(50)),
									$mdgriffith$elm_ui$Element$width(
									$mdgriffith$elm_ui$Element$px(100)),
									$mdgriffith$elm_ui$Element$padding(8)
								]),
							{
								label: $mdgriffith$elm_ui$Element$text('Local'),
								onPress: $elm$core$Maybe$Just(rightSidebarMsg)
							}),
							A2(
							$mdgriffith$elm_ui$Element$el,
							_List_Nil,
							function () {
								switch (connection.$) {
									case 'Connected':
										return $mdgriffith$elm_ui$Element$text('Connected');
									case 'Disconnected':
										return $mdgriffith$elm_ui$Element$text('Disconnected');
									default:
										return $mdgriffith$elm_ui$Element$text('Not asked');
								}
							}()),
							A2(
							$mdgriffith$elm_ui$Element$Input$button,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$playlistHeaderBackground),
									$mdgriffith$elm_ui$Element$height(
									$mdgriffith$elm_ui$Element$px(50)),
									$mdgriffith$elm_ui$Element$width(
									$mdgriffith$elm_ui$Element$px(50)),
									$mdgriffith$elm_ui$Element$centerX,
									$mdgriffith$elm_ui$Element$alignRight
								]),
							{
								label: $mdgriffith$elm_ui$Element$html(
									A2(
										$icidasset$elm_material_icons$Material$Icons$more_vert,
										32,
										$icidasset$elm_material_icons$Material$Icons$Types$Color($author$project$Colors$greyIcon))),
								onPress: $elm$core$Maybe$Just(rightSidebarMsg)
							}),
							A2(
							$mdgriffith$elm_ui$Element$Input$button,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$playlistHeaderBackground),
									$mdgriffith$elm_ui$Element$height(
									$mdgriffith$elm_ui$Element$px(50)),
									$mdgriffith$elm_ui$Element$width(
									$mdgriffith$elm_ui$Element$px(50)),
									$mdgriffith$elm_ui$Element$centerX,
									$mdgriffith$elm_ui$Element$alignRight
								]),
							{
								label: $mdgriffith$elm_ui$Element$text('>'),
								onPress: $elm$core$Maybe$Just(rightSidebarMsg)
							})
						])),
					A2(
					$mdgriffith$elm_ui$Element$el,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$playlistBackground),
							$mdgriffith$elm_ui$Element$padding(8)
						]),
					$mdgriffith$elm_ui$Element$text('Test'))
				])) : A2(
			$mdgriffith$elm_ui$Element$column,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(panelHeight)),
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(50)),
					$mdgriffith$elm_ui$Element$Background$color($author$project$Colors$playlistBackground),
					$mdgriffith$elm_ui$Element$alignRight,
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'pointer-events', 'all'))
				]),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$Input$button,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$centerX,
							$mdgriffith$elm_ui$Element$height(
							$mdgriffith$elm_ui$Element$px(50))
						]),
					{
						label: $mdgriffith$elm_ui$Element$text('<'),
						onPress: $elm$core$Maybe$Just(rightSidebarMsg)
					})
				]));
	});
var $PaackEng$elm_ui_dialog$Dialog$dialogMask = A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0.3);
var $PaackEng$elm_ui_dialog$Dialog$wrapBody = function (_v0) {
	var body = _v0.body;
	var bodyAttributes = _v0.bodyAttributes;
	if (body.$ === 'Nothing') {
		return $mdgriffith$elm_ui$Element$none;
	} else {
		var body_ = body.a;
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$padding(1)
					]),
				bodyAttributes),
			body_);
	}
};
var $PaackEng$elm_ui_dialog$Dialog$wrapFooter = function (_v0) {
	var footer = _v0.footer;
	var footerAttributes = _v0.footerAttributes;
	if (footer.$ === 'Nothing') {
		return $mdgriffith$elm_ui$Element$none;
	} else {
		var footer_ = footer.a;
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$padding(1)
					]),
				footerAttributes),
			footer_);
	}
};
var $PaackEng$elm_ui_dialog$Dialog$closeButton = function (closeMessage) {
	return A2(
		$mdgriffith$elm_ui$Element$Input$button,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$alignRight,
				$mdgriffith$elm_ui$Element$padding(1),
				$mdgriffith$elm_ui$Element$Font$size(16)
			]),
		{
			label: $mdgriffith$elm_ui$Element$text('x'),
			onPress: $elm$core$Maybe$Just(closeMessage)
		});
};
var $PaackEng$elm_ui_dialog$Dialog$maybe = F3(
	function (_default, f, value) {
		if (value.$ === 'Just') {
			var value_ = value.a;
			return f(value_);
		} else {
			return _default;
		}
	});
var $PaackEng$elm_ui_dialog$Dialog$wrapHeader = function (_v0) {
	var header = _v0.header;
	var headerAttributes = _v0.headerAttributes;
	var closeMessage = _v0.closeMessage;
	return (_Utils_eq(header, $elm$core$Maybe$Nothing) && _Utils_eq(closeMessage, $elm$core$Maybe$Nothing)) ? $mdgriffith$elm_ui$Element$none : A2(
		$mdgriffith$elm_ui$Element$row,
		_Utils_ap(
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$padding(2)
				]),
			headerAttributes),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$el,
				_List_fromArray(
					[$mdgriffith$elm_ui$Element$alignLeft]),
				A2($elm$core$Maybe$withDefault, $mdgriffith$elm_ui$Element$none, header)),
				A3($PaackEng$elm_ui_dialog$Dialog$maybe, $mdgriffith$elm_ui$Element$none, $PaackEng$elm_ui_dialog$Dialog$closeButton, closeMessage)
			]));
};
var $PaackEng$elm_ui_dialog$Dialog$view = function (maybeConfig) {
	if (maybeConfig.$ === 'Nothing') {
		return $mdgriffith$elm_ui$Element$none;
	} else {
		var config = maybeConfig.a;
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Background$color($PaackEng$elm_ui_dialog$Dialog$dialogMask),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
					]),
				config.maskAttributes),
			A2(
				$mdgriffith$elm_ui$Element$column,
				config.containerAttributes,
				_List_fromArray(
					[
						$PaackEng$elm_ui_dialog$Dialog$wrapHeader(config),
						$PaackEng$elm_ui_dialog$Dialog$wrapBody(config),
						$PaackEng$elm_ui_dialog$Dialog$wrapFooter(config)
					])));
	}
};
var $author$project$Components$Frame$layout = function (layoutType) {
	var dialogConfig = function () {
		var _v0 = layoutType.dialogBox.showDialog;
		switch (_v0.$) {
			case 'ConnectionDialog':
				return $elm$core$Maybe$Just(
					$author$project$Components$DialogView$config(layoutType.dialogBox.attemptReconnectionMsg));
			case 'TextInputDialog':
				return $elm$core$Maybe$Just(
					A3($author$project$Components$DialogView$textInputConfig, layoutType.dialogBox.playlistName, layoutType.dialogBox.closeDialogMsg, layoutType.dialogBox.textChangeMsg));
			default:
				return $elm$core$Maybe$Nothing;
		}
	}();
	return {
		body: {
			body: _List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
						]),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Element$el,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$height(
									$mdgriffith$elm_ui$Element$px($author$project$Components$Header$headerHeight))
								]),
							$mdgriffith$elm_ui$Element$none),
							A2(
							$mdgriffith$elm_ui$Element$row,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
									$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
									$mdgriffith$elm_ui$Element$paddingEach(
									{bottom: 0, left: 50, right: 0, top: 0})
								]),
							_List_fromArray(
								[
									A2(
									$mdgriffith$elm_ui$Element$column,
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
											$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
										]),
									layoutType.page.body)
								]))
						]))
				]),
			title: layoutType.page.title
		},
		dialogBox: $PaackEng$elm_ui_dialog$Dialog$view(dialogConfig),
		header: $author$project$Components$Header$view(layoutType.searchChanged),
		leftSidebar: $author$project$Components$LeftSidebar$view,
		playerBar: $author$project$Components$PlayerRow$view(layoutType),
		rightSidebar: A4($author$project$Components$RightSidebar$view, layoutType.rightSidebarExtended, layoutType.rightSidebarMsg, layoutType.windowHeight - $author$project$Components$PlayerRow$playerHeight, layoutType.connection)
	};
};
var $elm$core$String$toFloat = _String_toFloat;
var $carwow$elm_slider$SingleSlider$inputDecoder = A2(
	$elm$json$Json$Decode$map,
	function (value) {
		return A2(
			$elm$core$Maybe$withDefault,
			0,
			$elm$core$String$toFloat(value));
	},
	$elm$html$Html$Events$targetValue);
var $debois$elm_dom$DOM$offsetHeight = A2($elm$json$Json$Decode$field, 'offsetHeight', $elm$json$Json$Decode$float);
var $debois$elm_dom$DOM$offsetWidth = A2($elm$json$Json$Decode$field, 'offsetWidth', $elm$json$Json$Decode$float);
var $elm$json$Json$Decode$map4 = _Json_map4;
var $debois$elm_dom$DOM$offsetLeft = A2($elm$json$Json$Decode$field, 'offsetLeft', $elm$json$Json$Decode$float);
var $debois$elm_dom$DOM$offsetParent = F2(
	function (x, decoder) {
		return $elm$json$Json$Decode$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$json$Json$Decode$field,
					'offsetParent',
					$elm$json$Json$Decode$null(x)),
					A2($elm$json$Json$Decode$field, 'offsetParent', decoder)
				]));
	});
var $debois$elm_dom$DOM$offsetTop = A2($elm$json$Json$Decode$field, 'offsetTop', $elm$json$Json$Decode$float);
var $debois$elm_dom$DOM$scrollLeft = A2($elm$json$Json$Decode$field, 'scrollLeft', $elm$json$Json$Decode$float);
var $debois$elm_dom$DOM$scrollTop = A2($elm$json$Json$Decode$field, 'scrollTop', $elm$json$Json$Decode$float);
var $debois$elm_dom$DOM$position = F2(
	function (x, y) {
		return A2(
			$elm$json$Json$Decode$andThen,
			function (_v0) {
				var x_ = _v0.a;
				var y_ = _v0.b;
				return A2(
					$debois$elm_dom$DOM$offsetParent,
					_Utils_Tuple2(x_, y_),
					A2($debois$elm_dom$DOM$position, x_, y_));
			},
			A5(
				$elm$json$Json$Decode$map4,
				F4(
					function (scrollLeftP, scrollTopP, offsetLeftP, offsetTopP) {
						return _Utils_Tuple2((x + offsetLeftP) - scrollLeftP, (y + offsetTopP) - scrollTopP);
					}),
				$debois$elm_dom$DOM$scrollLeft,
				$debois$elm_dom$DOM$scrollTop,
				$debois$elm_dom$DOM$offsetLeft,
				$debois$elm_dom$DOM$offsetTop));
	});
var $debois$elm_dom$DOM$boundingClientRect = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (_v0, width, height) {
			var x = _v0.a;
			var y = _v0.b;
			return {height: height, left: x, top: y, width: width};
		}),
	A2($debois$elm_dom$DOM$position, 0, 0),
	$debois$elm_dom$DOM$offsetWidth,
	$debois$elm_dom$DOM$offsetHeight);
var $myrho$elm_round$Round$funNum = F3(
	function (fun, s, fl) {
		return A2(
			$elm$core$Maybe$withDefault,
			0 / 0,
			$elm$core$String$toFloat(
				A2(fun, s, fl)));
	});
var $elm$core$Basics$abs = function (n) {
	return (n < 0) ? (-n) : n;
};
var $elm$core$String$foldr = _String_foldr;
var $elm$core$String$toList = function (string) {
	return A3($elm$core$String$foldr, $elm$core$List$cons, _List_Nil, string);
};
var $myrho$elm_round$Round$addSign = F2(
	function (signed, str) {
		var isNotZero = A2(
			$elm$core$List$any,
			function (c) {
				return (!_Utils_eq(
					c,
					_Utils_chr('0'))) && (!_Utils_eq(
					c,
					_Utils_chr('.')));
			},
			$elm$core$String$toList(str));
		return _Utils_ap(
			(signed && isNotZero) ? '-' : '',
			str);
	});
var $elm$core$Char$fromCode = _Char_fromCode;
var $myrho$elm_round$Round$increaseNum = function (_v0) {
	var head = _v0.a;
	var tail = _v0.b;
	if (_Utils_eq(
		head,
		_Utils_chr('9'))) {
		var _v1 = $elm$core$String$uncons(tail);
		if (_v1.$ === 'Nothing') {
			return '01';
		} else {
			var headtail = _v1.a;
			return A2(
				$elm$core$String$cons,
				_Utils_chr('0'),
				$myrho$elm_round$Round$increaseNum(headtail));
		}
	} else {
		var c = $elm$core$Char$toCode(head);
		return ((c >= 48) && (c < 57)) ? A2(
			$elm$core$String$cons,
			$elm$core$Char$fromCode(c + 1),
			tail) : '0';
	}
};
var $elm$core$Basics$isInfinite = _Basics_isInfinite;
var $elm$core$Basics$isNaN = _Basics_isNaN;
var $elm$core$String$padRight = F3(
	function (n, _char, string) {
		return _Utils_ap(
			string,
			A2(
				$elm$core$String$repeat,
				n - $elm$core$String$length(string),
				$elm$core$String$fromChar(_char)));
	});
var $elm$core$String$reverse = _String_reverse;
var $myrho$elm_round$Round$splitComma = function (str) {
	var _v0 = A2($elm$core$String$split, '.', str);
	if (_v0.b) {
		if (_v0.b.b) {
			var before = _v0.a;
			var _v1 = _v0.b;
			var after = _v1.a;
			return _Utils_Tuple2(before, after);
		} else {
			var before = _v0.a;
			return _Utils_Tuple2(before, '0');
		}
	} else {
		return _Utils_Tuple2('0', '0');
	}
};
var $myrho$elm_round$Round$toDecimal = function (fl) {
	var _v0 = A2(
		$elm$core$String$split,
		'e',
		$elm$core$String$fromFloat(
			$elm$core$Basics$abs(fl)));
	if (_v0.b) {
		if (_v0.b.b) {
			var num = _v0.a;
			var _v1 = _v0.b;
			var exp = _v1.a;
			var e = A2(
				$elm$core$Maybe$withDefault,
				0,
				$elm$core$String$toInt(
					A2($elm$core$String$startsWith, '+', exp) ? A2($elm$core$String$dropLeft, 1, exp) : exp));
			var _v2 = $myrho$elm_round$Round$splitComma(num);
			var before = _v2.a;
			var after = _v2.b;
			var total = _Utils_ap(before, after);
			var zeroed = (e < 0) ? A2(
				$elm$core$Maybe$withDefault,
				'0',
				A2(
					$elm$core$Maybe$map,
					function (_v3) {
						var a = _v3.a;
						var b = _v3.b;
						return a + ('.' + b);
					},
					A2(
						$elm$core$Maybe$map,
						$elm$core$Tuple$mapFirst($elm$core$String$fromChar),
						$elm$core$String$uncons(
							_Utils_ap(
								A2(
									$elm$core$String$repeat,
									$elm$core$Basics$abs(e),
									'0'),
								total))))) : A3(
				$elm$core$String$padRight,
				e + 1,
				_Utils_chr('0'),
				total);
			return _Utils_ap(
				(fl < 0) ? '-' : '',
				zeroed);
		} else {
			var num = _v0.a;
			return _Utils_ap(
				(fl < 0) ? '-' : '',
				num);
		}
	} else {
		return '';
	}
};
var $myrho$elm_round$Round$roundFun = F3(
	function (functor, s, fl) {
		if ($elm$core$Basics$isInfinite(fl) || $elm$core$Basics$isNaN(fl)) {
			return $elm$core$String$fromFloat(fl);
		} else {
			var signed = fl < 0;
			var _v0 = $myrho$elm_round$Round$splitComma(
				$myrho$elm_round$Round$toDecimal(
					$elm$core$Basics$abs(fl)));
			var before = _v0.a;
			var after = _v0.b;
			var r = $elm$core$String$length(before) + s;
			var normalized = _Utils_ap(
				A2($elm$core$String$repeat, (-r) + 1, '0'),
				A3(
					$elm$core$String$padRight,
					r,
					_Utils_chr('0'),
					_Utils_ap(before, after)));
			var totalLen = $elm$core$String$length(normalized);
			var roundDigitIndex = A2($elm$core$Basics$max, 1, r);
			var increase = A2(
				functor,
				signed,
				A3($elm$core$String$slice, roundDigitIndex, totalLen, normalized));
			var remains = A3($elm$core$String$slice, 0, roundDigitIndex, normalized);
			var num = increase ? $elm$core$String$reverse(
				A2(
					$elm$core$Maybe$withDefault,
					'1',
					A2(
						$elm$core$Maybe$map,
						$myrho$elm_round$Round$increaseNum,
						$elm$core$String$uncons(
							$elm$core$String$reverse(remains))))) : remains;
			var numLen = $elm$core$String$length(num);
			var numZeroed = (num === '0') ? num : ((s <= 0) ? _Utils_ap(
				num,
				A2(
					$elm$core$String$repeat,
					$elm$core$Basics$abs(s),
					'0')) : ((_Utils_cmp(
				s,
				$elm$core$String$length(after)) < 0) ? (A3($elm$core$String$slice, 0, numLen - s, num) + ('.' + A3($elm$core$String$slice, numLen - s, numLen, num))) : _Utils_ap(
				before + '.',
				A3(
					$elm$core$String$padRight,
					s,
					_Utils_chr('0'),
					after))));
			return A2($myrho$elm_round$Round$addSign, signed, numZeroed);
		}
	});
var $myrho$elm_round$Round$round = $myrho$elm_round$Round$roundFun(
	F2(
		function (signed, str) {
			var _v0 = $elm$core$String$uncons(str);
			if (_v0.$ === 'Nothing') {
				return false;
			} else {
				if ('5' === _v0.a.a.valueOf()) {
					if (_v0.a.b === '') {
						var _v1 = _v0.a;
						return !signed;
					} else {
						var _v2 = _v0.a;
						return true;
					}
				} else {
					var _v3 = _v0.a;
					var _int = _v3.a;
					return function (i) {
						return ((i > 53) && signed) || ((i >= 53) && (!signed));
					}(
						$elm$core$Char$toCode(_int));
				}
			}
		}));
var $myrho$elm_round$Round$roundNum = $myrho$elm_round$Round$funNum($myrho$elm_round$Round$round);
var $carwow$elm_slider$RangeSlider$snapValue = F2(
	function (value, step) {
		var stepDecimals = $elm$core$List$head(
			A2(
				$elm$core$List$drop,
				1,
				A2(
					$elm$core$String$split,
					'.',
					$elm$core$String$fromFloat(step))));
		var precision = function () {
			if (stepDecimals.$ === 'Just') {
				var s = stepDecimals.a;
				return $elm$core$String$length(s);
			} else {
				return 0;
			}
		}();
		return A2(
			$myrho$elm_round$Round$roundNum,
			precision,
			$elm$core$Basics$round(value / step) * step);
	});
var $carwow$elm_slider$SingleSlider$onOutsideRangeClick = function (_v0) {
	var slider = _v0.a;
	var commonAttributes = slider.commonAttributes;
	var valueDecoder = A3(
		$elm$json$Json$Decode$map2,
		F2(
			function (rectangle, mouseX) {
				var clickedValue = (((commonAttributes.max - commonAttributes.min) / rectangle.width) * mouseX) + commonAttributes.min;
				return A2($carwow$elm_slider$RangeSlider$snapValue, clickedValue, commonAttributes.step);
			}),
		A2(
			$elm$json$Json$Decode$at,
			_List_fromArray(
				['target']),
			$debois$elm_dom$DOM$boundingClientRect),
		A2(
			$elm$json$Json$Decode$at,
			_List_fromArray(
				['offsetX']),
			$elm$json$Json$Decode$float));
	return A2($elm$json$Json$Decode$map, slider.valueAttributes.change, valueDecoder);
};
var $elm$core$Basics$clamp = F3(
	function (low, high, number) {
		return (_Utils_cmp(number, low) < 0) ? low : ((_Utils_cmp(number, high) > 0) ? high : number);
	});
var $carwow$elm_slider$RangeSlider$onClick = function (decoder) {
	return A2($elm$html$Html$Events$on, 'click', decoder);
};
var $carwow$elm_slider$SingleSlider$onInsideRangeClick = function (_v0) {
	var commonAttributes = _v0.a.commonAttributes;
	var valueAttributes = _v0.a.valueAttributes;
	var valueDecoder = A3(
		$elm$json$Json$Decode$map2,
		F2(
			function (rectangle, mouseX) {
				var adjustedValue = A3($elm$core$Basics$clamp, commonAttributes.min, commonAttributes.max, valueAttributes.value);
				var newValue = $elm$core$Basics$round((adjustedValue / rectangle.width) * mouseX);
				var adjustedNewValue = A3($elm$core$Basics$clamp, commonAttributes.min, commonAttributes.max, newValue);
				return A2($carwow$elm_slider$RangeSlider$snapValue, adjustedNewValue, commonAttributes.step);
			}),
		A2(
			$elm$json$Json$Decode$at,
			_List_fromArray(
				['target']),
			$debois$elm_dom$DOM$boundingClientRect),
		A2(
			$elm$json$Json$Decode$at,
			_List_fromArray(
				['offsetX']),
			$elm$json$Json$Decode$float));
	return A2($elm$json$Json$Decode$map, valueAttributes.change, valueDecoder);
};
var $carwow$elm_slider$SingleSlider$progressView = function (_v0) {
	var slider = _v0.a;
	var commonAttributes = slider.commonAttributes;
	var valueAttributes = slider.valueAttributes;
	var value = A3($elm$core$Basics$clamp, commonAttributes.min, commonAttributes.max, valueAttributes.value);
	var progressRatio = 100 / (commonAttributes.max - commonAttributes.min);
	var progress = (commonAttributes.max - value) * progressRatio;
	var progressAttributes = _List_fromArray(
		[
			$elm$html$Html$Attributes$class('input-range__progress'),
			A2($elm$html$Html$Attributes$style, 'left', '0.0%'),
			A2(
			$elm$html$Html$Attributes$style,
			'right',
			$elm$core$String$fromFloat(progress) + '%'),
			$carwow$elm_slider$RangeSlider$onClick(
			$carwow$elm_slider$SingleSlider$onInsideRangeClick(
				$carwow$elm_slider$SingleSlider$SingleSlider(slider)))
		]);
	return A2($elm$html$Html$div, progressAttributes, _List_Nil);
};
var $elm$html$Html$Attributes$classList = function (classes) {
	return $elm$html$Html$Attributes$class(
		A2(
			$elm$core$String$join,
			' ',
			A2(
				$elm$core$List$map,
				$elm$core$Tuple$first,
				A2($elm$core$List$filter, $elm$core$Tuple$second, classes))));
};
var $carwow$elm_slider$RangeSlider$onChange = F2(
	function (msg, input) {
		return A2(
			$elm$html$Html$Events$on,
			'change',
			A2($elm$json$Json$Decode$map, msg, input));
	});
var $carwow$elm_slider$RangeSlider$onInput = F2(
	function (msg, input) {
		return A2(
			$elm$html$Html$Events$on,
			'input',
			A2($elm$json$Json$Decode$map, msg, input));
	});
var $elm$html$Html$Attributes$step = function (n) {
	return A2($elm$html$Html$Attributes$stringProperty, 'step', n);
};
var $carwow$elm_slider$RangeSlider$sliderInputView = F4(
	function (commonAttributes, valueAttributes, input, extraClasses) {
		return A2(
			$elm$html$Html$input,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$type_('range'),
					$elm$html$Html$Attributes$min(
					$elm$core$String$fromFloat(commonAttributes.min)),
					$elm$html$Html$Attributes$max(
					$elm$core$String$fromFloat(commonAttributes.max)),
					$elm$html$Html$Attributes$step(
					$elm$core$String$fromFloat(commonAttributes.step)),
					$elm$html$Html$Attributes$value(
					$elm$core$String$fromFloat(valueAttributes.value)),
					$elm$html$Html$Attributes$class('input-range'),
					$elm$html$Html$Attributes$classList(
					A2(
						$elm$core$List$map,
						function (c) {
							return _Utils_Tuple2(c, true);
						},
						extraClasses)),
					A2($carwow$elm_slider$RangeSlider$onChange, valueAttributes.change, input),
					A2($carwow$elm_slider$RangeSlider$onInput, valueAttributes.change, input)
				]),
			_List_Nil);
	});
var $carwow$elm_slider$RangeSlider$sliderTrackView = function (decoder) {
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				$elm$html$Html$Attributes$class('input-range__track'),
				$carwow$elm_slider$RangeSlider$onClick(decoder)
			]),
		_List_Nil);
};
var $carwow$elm_slider$SingleSlider$view = function (_v0) {
	var slider = _v0.a;
	return A2(
		$elm$html$Html$div,
		_List_Nil,
		_List_fromArray(
			[
				A2(
				$elm$html$Html$div,
				_List_fromArray(
					[
						$elm$html$Html$Attributes$class('input-range-container')
					]),
				_List_fromArray(
					[
						A4($carwow$elm_slider$RangeSlider$sliderInputView, slider.commonAttributes, slider.valueAttributes, $carwow$elm_slider$SingleSlider$inputDecoder, _List_Nil),
						$carwow$elm_slider$RangeSlider$sliderTrackView(
						$carwow$elm_slider$SingleSlider$onOutsideRangeClick(
							$carwow$elm_slider$SingleSlider$SingleSlider(slider))),
						$carwow$elm_slider$SingleSlider$progressView(
						$carwow$elm_slider$SingleSlider$SingleSlider(slider))
					])),
				A2(
				$elm$html$Html$div,
				_List_fromArray(
					[
						$elm$html$Html$Attributes$class('input-range-labels-container')
					]),
				_List_fromArray(
					[
						A2(
						$elm$html$Html$div,
						_List_fromArray(
							[
								$elm$html$Html$Attributes$class('input-range-label')
							]),
						_List_fromArray(
							[
								$elm$html$Html$text(
								slider.commonAttributes.minFormatter(slider.commonAttributes.min))
							])),
						A2(
						$elm$html$Html$div,
						_List_fromArray(
							[
								$elm$html$Html$Attributes$class('input-range-label input-range-label--current-value')
							]),
						_List_fromArray(
							[
								$elm$html$Html$text(
								A2(slider.valueAttributes.formatter, slider.valueAttributes.value, slider.commonAttributes.max))
							])),
						A2(
						$elm$html$Html$div,
						_List_fromArray(
							[
								$elm$html$Html$Attributes$class('input-range-label')
							]),
						_List_fromArray(
							[
								$elm$html$Html$text(
								slider.commonAttributes.maxFormatter(slider.commonAttributes.max))
							]))
					]))
			]));
};
var $author$project$Shared$slider = function (singleSliderMsg) {
	return $mdgriffith$elm_ui$Element$html(
		$carwow$elm_slider$SingleSlider$view(singleSliderMsg));
};
var $author$project$Shared$view = F2(
	function (_v0, model) {
		var page = _v0.page;
		var toMsg = _v0.toMsg;
		return $author$project$Components$Frame$layout(
			{
				connection: model.connection,
				controlMenu: {
					controlMenu: model.controlMenu,
					controlMenuMsg: toMsg($author$project$Shared$ToggleControlMenu),
					scanMusicLibraryMsg: toMsg($author$project$Shared$ScanMusicLibrary),
					scanVideoLibraryMsg: toMsg($author$project$Shared$ScanVideoLibrary),
					sendTextToKodiMsg: toMsg($author$project$Shared$SendTextToKodi)
				},
				currentlyPlaying: {
					currentlyPlaying: model.currentlyPlaying,
					progressSlider: A2(
						$mdgriffith$elm_ui$Element$map,
						toMsg,
						$author$project$Shared$slider(model.progressSlider))
				},
				dialogBox: {
					attemptReconnectionMsg: toMsg($author$project$Shared$AttemptReconnectionDialog),
					closeDialogMsg: toMsg($author$project$Shared$CloseDialog),
					playlistName: model.playlistName,
					showDialog: model.showDialog,
					textChangeMsg: A2($elm$core$Basics$composeR, $author$project$Shared$NewPlaylist, toMsg)
				},
				page: page,
				playerControl: {
					playPauseMsg: toMsg($author$project$Shared$PlayPause),
					playing: model.playing,
					reverseMsg: toMsg($author$project$Shared$SkipPrevious),
					skipMsg: toMsg($author$project$Shared$SkipForward)
				},
				rightSidebarExtended: model.rightSidebarExtended,
				rightSidebarMsg: toMsg($author$project$Shared$ToggleRightSidebar),
				searchChanged: A2($elm$core$Basics$composeR, $author$project$Shared$SearchChanged, toMsg),
				volumeAndControls: {
					muteMsg: toMsg($author$project$Shared$ToggleMute),
					repeatMsg: toMsg(
						A2(
							$author$project$Shared$Request,
							$author$project$Method$Player_SetRepeat,
							$elm$core$Maybe$Just(
								A3(
									$author$project$Request$Params,
									$elm$core$Maybe$Just(0),
									$elm$core$Maybe$Nothing,
									$elm$core$Maybe$Nothing)))),
					shuffleMsg: toMsg($author$project$Shared$ToggleShuffle),
					volumeSlider: A2(
						$mdgriffith$elm_ui$Element$map,
						toMsg,
						$author$project$Shared$slider(model.volumeSlider))
				},
				windowHeight: model.windowHeight
			});
	});
var $author$project$Spa$Generated$Pages$view = A2(
	$elm$core$Basics$composeR,
	$author$project$Spa$Generated$Pages$bundle,
	function ($) {
		return $.view;
	});
var $author$project$Main$view = function (model) {
	return A2(
		$author$project$Shared$view,
		{
			page: A2(
				$author$project$Spa$Document$map,
				$author$project$Main$Pages,
				$author$project$Spa$Generated$Pages$view(model.page)),
			toMsg: $author$project$Main$Shared
		},
		model.shared);
};
var $author$project$Main$main = $elm$browser$Browser$application(
	{
		init: $author$project$Main$init,
		onUrlChange: $author$project$Main$UrlChanged,
		onUrlRequest: $author$project$Main$LinkClicked,
		subscriptions: $author$project$Main$subscriptions,
		update: $author$project$Main$update,
		view: A2($elm$core$Basics$composeR, $author$project$Main$view, $author$project$Spa$Document$toBrowserDocument)
	});
_Platform_export({'Main':{'init':$author$project$Main$main(
	A2(
		$elm$json$Json$Decode$andThen,
		function (localPlaylists) {
			return A2(
				$elm$json$Json$Decode$andThen,
				function (innerWidth) {
					return A2(
						$elm$json$Json$Decode$andThen,
						function (innerHeight) {
							return $elm$json$Json$Decode$succeed(
								{innerHeight: innerHeight, innerWidth: innerWidth, localPlaylists: localPlaylists});
						},
						A2($elm$json$Json$Decode$field, 'innerHeight', $elm$json$Json$Decode$int));
				},
				A2($elm$json$Json$Decode$field, 'innerWidth', $elm$json$Json$Decode$int));
		},
		A2(
			$elm$json$Json$Decode$field,
			'localPlaylists',
			$elm$json$Json$Decode$oneOf(
				_List_fromArray(
					[
						$elm$json$Json$Decode$null($elm$core$Maybe$Nothing),
						A2($elm$json$Json$Decode$map, $elm$core$Maybe$Just, $elm$json$Json$Decode$string)
					])))))({"versions":{"elm":"0.19.1"},"types":{"message":"Main.Msg","aliases":{"Url.Url":{"args":[],"type":"{ protocol : Url.Protocol, host : String.String, port_ : Maybe.Maybe Basics.Int, path : String.String, query : Maybe.Maybe String.String, fragment : Maybe.Maybe String.String }"},"WSDecoder.Item":{"args":[],"type":"{ id : Basics.Int, itype : String.String }"},"Request.Limit":{"args":[],"type":"{ start : Basics.Int, end : Basics.Int }"},"Pages.Help.Msg":{"args":[],"type":"Basics.Never"},"Pages.NotFound.Msg":{"args":[],"type":"Basics.Never"},"Pages.Top.Msg":{"args":[],"type":"Basics.Never"},"Request.Params":{"args":[],"type":"{ playerid : Maybe.Maybe Basics.Int, properties : Maybe.Maybe (List.List Request.Property), limits : Maybe.Maybe Request.Limit }"},"WSDecoder.ParamsResponse":{"args":[],"type":"{ item : WSDecoder.Item, player : WSDecoder.PlayerObj }"},"WSDecoder.AlbumObj":{"args":[],"type":"{ label : String.String, albumid : Basics.Int, artist : List.List String.String, thumbnail : String.String, genre : List.List String.String, playcount : Basics.Int, dateadded : String.String }"},"WSDecoder.ArtistObj":{"args":[],"type":"{ label : String.String, artistid : Basics.Int, thumbnail : String.String, genre : List.List String.String }"},"WSDecoder.FileObj":{"args":[],"type":"{ label : String.String, file : String.String, filetype : WSDecoder.FileType }"},"WSDecoder.ItemDetails":{"args":[],"type":"{ title : String.String, artist : List.List String.String, duration : Basics.Int, thumbnail : String.String }"},"WSDecoder.MovieObj":{"args":[],"type":"{ label : String.String, movieid : Basics.Int, thumbnail : String.String, file : String.String }"},"WSDecoder.Path":{"args":[],"type":"{ path : String.String }"},"WSDecoder.SongObj":{"args":[],"type":"{ label : String.String, artist : List.List String.String, duration : Basics.Int, songid : Basics.Int, albumid : Basics.Int, genre : List.List String.String }"},"WSDecoder.SourceObj":{"args":[],"type":"{ label : String.String, file : String.String }"},"WSDecoder.TvshowObj":{"args":[],"type":"{ label : String.String, tvshowid : Basics.Int, thumbnail : String.String }"}},"unions":{"Main.Msg":{"args":[],"tags":{"LinkClicked":["Browser.UrlRequest"],"UrlChanged":["Url.Url"],"Shared":["Shared.Msg"],"Pages":["Spa.Generated.Pages.Msg"],"GotNewSize":["Basics.Int","Basics.Int"]}},"Basics.Int":{"args":[],"tags":{"Int":[]}},"Maybe.Maybe":{"args":["a"],"tags":{"Just":["a"],"Nothing":[]}},"Shared.Msg":{"args":[],"tags":{"Navigate":["Spa.Generated.Route.Route"],"Request":["Method.Method","Maybe.Maybe Request.Params"],"Recv":["String.String"],"PlayPause":[],"SkipForward":[],"SkipPrevious":[],"ToggleMute":[],"ToggleShuffle":[],"ToggleRepeat":[],"QueryPlayers":["Time.Posix"],"ReceiveParamsResponse":["WSDecoder.ParamsResponse"],"ReceiveResultResponse":["WSDecoder.ResultResponse"],"ToggleRightSidebar":[],"ToggleControlMenu":[],"SendTextToKodi":[],"ScanVideoLibrary":[],"ScanMusicLibrary":[],"VolumeSliderChange":["Basics.Float"],"ProgressSliderChange":["Basics.Float"],"SearchChanged":["String.String"],"AttemptReconnectionDialog":[],"CloseDialog":[],"NewPlaylist":["String.String"]}},"Spa.Generated.Pages.Msg":{"args":[],"tags":{"Top__Msg":["Pages.Top.Msg"],"Addons__Msg":["Pages.Addons.Msg"],"Browser__Msg":["Pages.Browser.Msg"],"Help__Msg":["Pages.Help.Msg"],"Lab__Msg":["Pages.Lab.Msg"],"Movies__Msg":["Pages.Movies.Msg"],"Music__Msg":["Pages.Music.Msg"],"NotFound__Msg":["Pages.NotFound.Msg"],"Playlists__Msg":["Pages.Playlists.Msg"],"Thumbsup__Msg":["Pages.Thumbsup.Msg"],"Tvshows__Msg":["Pages.Tvshows.Msg"],"Movies__Recent__Msg":["Pages.Movies.Recent.Msg"],"Music__Albums__Msg":["Pages.Music.Albums.Msg"],"Music__Artists__Msg":["Pages.Music.Artists.Msg"],"Music__Genres__Msg":["Pages.Music.Genres.Msg"],"Music__Videos__Msg":["Pages.Music.Videos.Msg"],"Settings__Addons__Msg":["Pages.Settings.Addons.Msg"],"Settings__Nav__Msg":["Pages.Settings.Nav.Msg"],"Settings__Search__Msg":["Pages.Settings.Search.Msg"],"Settings__Web__Msg":["Pages.Settings.Web.Msg"],"Tvshows__Recent__Msg":["Pages.Tvshows.Recent.Msg"],"Browser__Source_String__Msg":["Pages.Browser.Source_String.Msg"],"Playlists__Name_String__Msg":["Pages.Playlists.Name_String.Msg"],"Videoplayer__Movieid_Int__Msg":["Pages.Videoplayer.Movieid_Int.Msg"],"Music__Top__Top__Msg":["Pages.Music.Top.Top.Msg"],"Settings__Kodi__Games__Msg":["Pages.Settings.Kodi.Games.Msg"],"Settings__Kodi__Interface__Msg":["Pages.Settings.Kodi.Interface.Msg"],"Settings__Kodi__Media__Msg":["Pages.Settings.Kodi.Media.Msg"],"Settings__Kodi__Player__Msg":["Pages.Settings.Kodi.Player.Msg"],"Settings__Kodi__Pvr__Msg":["Pages.Settings.Kodi.Pvr.Msg"],"Settings__Kodi__Services__Msg":["Pages.Settings.Kodi.Services.Msg"],"Settings__Kodi__System__Msg":["Pages.Settings.Kodi.System.Msg"],"Music__Album__Albumid_Int__Msg":["Pages.Music.Album.Albumid_Int.Msg"],"Music__Artist__Artistid_Int__Msg":["Pages.Music.Artist.Artistid_Int.Msg"],"Music__Genre__Genre_String__Msg":["Pages.Music.Genre.Genre_String.Msg"]}},"Url.Protocol":{"args":[],"tags":{"Http":[],"Https":[]}},"String.String":{"args":[],"tags":{"String":[]}},"Browser.UrlRequest":{"args":[],"tags":{"Internal":["Url.Url"],"External":["String.String"]}},"Basics.Float":{"args":[],"tags":{"Float":[]}},"List.List":{"args":["a"],"tags":{}},"Method.Method":{"args":[],"tags":{"JSONRPC_Introspect":[],"JSONRPC_Version":[],"JSONRPC_Permission":[],"JSONRPC_Ping":[],"JSONRPC_GetConfiguration":[],"JSONRPC_SetConfiguration":[],"JSONRPC_NotifyAll":[],"Player_Open":[],"Player_GetActivePlayers":[],"Player_GetPlayers":[],"Player_GetProperties":[],"Player_GetItem":[],"Player_PlayPause":[],"Player_Stop":[],"Player_SetSpeed":[],"Player_Seek":[],"Player_Move":[],"Player_Zoom":[],"Player_SetViewMode":[],"Player_GetViewMode":[],"Player_Rotate":[],"Player_GoTo":[],"Player_SetShuffle":[],"Player_SetRepeat":[],"Player_SetPartymode":[],"Player_SetAudioStream":[],"Player_SetVideoStream":[],"Player_SetSubtitle":[],"Playlist_GetPlaylists":[],"Playlist_GetProperties":[],"Playlist_GetItems":[],"Playlist_Add":[],"Playlist_Insert":[],"Playlist_Remove":[],"Playlist_Clear":[],"Playlist_Swap":[],"Files_GetSources":[],"Files_PrepareDownload":[],"Files_Download":[],"Files_GetDirectory":[],"Files_GetFileDetails":[],"Files_SetFileDetails":[],"AudioLibrary_GetProperties":[],"AudioLibrary_GetArtists":[],"AudioLibrary_GetArtistDetails":[],"AudioLibrary_GetAlbums":[],"AudioLibrary_GetAlbumDetails":[],"AudioLibrary_GetSongs":[],"AudioLibrary_GetSongDetails":[],"AudioLibrary_GetRecentlyAddedAlbums":[],"AudioLibrary_GetRecentlyAddedSongs":[],"AudioLibrary_GetRecentlyPlayedAlbums":[],"AudioLibrary_GetRecentlyPlayedSongs":[],"AudioLibrary_GetGenres":[],"AudioLibrary_GetSources":[],"AudioLibrary_GetRoles":[],"AudioLibrary_SetArtistDetails":[],"AudioLibrary_SetAlbumDetails":[],"AudioLibrary_SetSongDetails":[],"AudioLibrary_Scan":[],"AudioLibrary_Export":[],"AudioLibrary_Clean":[],"VideoLibrary_GetMovies":[],"VideoLibrary_GetMovieDetails":[],"VideoLibrary_GetMovieSets":[],"VideoLibrary_GetMovieSetDetails":[],"VideoLibrary_GetTVShows":[],"VideoLibrary_GetTVShowDetails":[],"VideoLibrary_GetSeasons":[],"VideoLibrary_GetSeasonDetails":[],"VideoLibrary_GetEpisodes":[],"VideoLibrary_GetEpisodeDetails":[],"VideoLibrary_GetMusicVideos":[],"VideoLibrary_GetMusicVideoDetails":[],"VideoLibrary_GetRecentlyAddedMovies":[],"VideoLibrary_GetRecentlyAddedEpisodes":[],"VideoLibrary_GetRecentlyAddedMusicVideos":[],"VideoLibrary_GetInProgressTVShows":[],"VideoLibrary_GetGenres":[],"VideoLibrary_GetTags":[],"VideoLibrary_SetMovieDetails":[],"VideoLibrary_SetMovieSetDetails":[],"VideoLibrary_SetTVShowDetails":[],"VideoLibrary_SetSeasonDetails":[],"VideoLibrary_SetEpisodeDetails":[],"VideoLibrary_SetMusicVideoDetails":[],"VideoLibrary_RefreshMovie":[],"VideoLibrary_RefreshTVShow":[],"VideoLibrary_RefreshEpisode":[],"VideoLibrary_RefreshMusicVideo":[],"VideoLibrary_RemoveMovie":[],"VideoLibrary_RemoveTVShow":[],"VideoLibrary_RemoveEpisode":[],"VideoLibrary_RemoveMusicVideo":[],"VideoLibrary_Scan":[],"VideoLibrary_Export":[],"VideoLibrary_Clean":[],"GUI_ActivateWindow":[],"GUI_ShowNotification":[],"GUI_GetProperties":[],"GUI_SetFullscreen":[],"GUI_SetStereoscopicMode":[],"GUI_GetStereoscopicModes":[],"Addons_GetAddons":[],"Addons_GetAddonDetails":[],"Addons_SetAddonEnabled":[],"Addons_ExecuteAddon":[],"PVR_GetProperties":[],"PVR_GetChannelGroups":[],"PVR_GetChannelGroupDetails":[],"PVR_GetChannels":[],"PVR_GetChannelDetails":[],"PVR_GetBroadcasts":[],"PVR_GetBroadcastDetails":[],"PVR_GetTimers":[],"PVR_GetTimerDetails":[],"PVR_AddTimer":[],"PVR_DeleteTimer":[],"PVR_ToggleTimer":[],"PVR_GetRecordings":[],"PVR_GetRecordingDetails":[],"PVR_Record":[],"PVR_Scan":[],"Textures_GetTextures":[],"Textures_RemoveTexture":[],"Profiles_GetProfiles":[],"Profiles_GetCurrentProfile":[],"Profiles_LoadProfile":[],"System_GetProperties":[],"System_EjectOpticalDrive":[],"System_Shutdown":[],"System_Suspend":[],"System_Hibernate":[],"System_Reboot":[],"Input_SendText":[],"Input_ExecuteAction":[],"Input_ButtonEvent":[],"Input_Left":[],"Input_Right":[],"Input_Down":[],"Input_Up":[],"Input_Select":[],"Input_Back":[],"Input_ContextMenu":[],"Input_Info":[],"Input_Home":[],"Input_ShowCodec":[],"Input_ShowOSD":[],"Input_ShowPlayerProcessInfo":[],"Application_GetProperties":[],"Application_SetVolume":[],"Application_SetMute":[],"Application_Quit":[],"XBMC_GetInfoLabels":[],"XBMC_GetInfoBooleans":[],"Favourites_GetFavourites":[],"Favourites_AddFavourite":[],"Settings_GetSections":[],"Settings_GetCategories":[],"Settings_GetSettings":[],"Settings_GetSettingValue":[],"Settings_SetSettingValue":[],"Settings_ResetSettingValue":[]}},"Pages.Addons.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Browser.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Browser.Source_String.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Lab.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Movies.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.MovieObj"]}},"Pages.Movies.Recent.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.MovieObj"],"NoOp":[]}},"Pages.Music.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.SongObj"]}},"Pages.Music.Album.Albumid_Int.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.SongObj"]}},"Pages.Music.Albums.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Music.Artist.Artistid_Int.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.SongObj"]}},"Pages.Music.Artists.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Music.Genre.Genre_String.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.SongObj"],"DoNothing":[]}},"Pages.Music.Genres.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.SongObj"]}},"Pages.Music.Top.Top.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.SongObj"]}},"Pages.Music.Videos.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Playlists.Msg":{"args":[],"tags":{"NewPlaylist":[],"CloseDialog":[]}},"Pages.Playlists.Name_String.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Addons.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Kodi.Games.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Kodi.Interface.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Kodi.Media.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Kodi.Player.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Kodi.Pvr.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Kodi.Services.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Kodi.System.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Nav.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Search.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Settings.Web.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Thumbsup.Msg":{"args":[],"tags":{"ReplaceMe":[]}},"Pages.Tvshows.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.TvshowObj"],"NoOp":[]}},"Pages.Tvshows.Recent.Msg":{"args":[],"tags":{"SetCurrentlyPlaying":["WSDecoder.TvshowObj"],"NoOp":[]}},"Pages.Videoplayer.Movieid_Int.Msg":{"args":[],"tags":{"GotMovie":["Result.Result Http.Error WSDecoder.Path"]}},"Basics.Never":{"args":[],"tags":{"JustOneMore":["Basics.Never"]}},"WSDecoder.PlayerObj":{"args":[],"tags":{"PlayerA":["Basics.Int","Basics.Int"],"PlayerB":["Basics.Int","WSDecoder.PlayerType","WSDecoder.PType"]}},"Time.Posix":{"args":[],"tags":{"Posix":["Basics.Int"]}},"Request.Property":{"args":[],"tags":{"Title":[],"Album":[],"Artist":[],"Season":[],"Episode":[],"Duration":[],"Showtitle":[],"TVshowid":[],"Thumbnail":[],"File":[],"Fanart":[],"Streamdetails":[],"Percentage":[],"Time":[],"Totaltime":[],"Speed":[]}},"WSDecoder.ResultResponse":{"args":[],"tags":{"ResultA":["String.String"],"ResultB":["List.List WSDecoder.PlayerObj"],"ResultC":["WSDecoder.ItemDetails"],"ResultD":["List.List WSDecoder.SongObj"],"ResultE":["List.List WSDecoder.ArtistObj"],"ResultF":["List.List WSDecoder.AlbumObj"],"ResultG":["List.List WSDecoder.MovieObj"],"ResultH":["Basics.Float","Basics.Int"],"ResultI":["List.List WSDecoder.SourceObj"],"ResultJ":["Basics.Bool","Basics.Float"],"ResultK":["List.List WSDecoder.FileObj"]}},"Spa.Generated.Route.Route":{"args":[],"tags":{"Top":[],"Addons":[],"Browser":[],"Help":[],"Lab":[],"Movies":[],"Music":[],"NotFound":[],"Playlists":[],"Thumbsup":[],"Tvshows":[],"Movies__Recent":[],"Music__Albums":[],"Music__Artists":[],"Music__Genres":[],"Music__Videos":[],"Settings__Addons":[],"Settings__Nav":[],"Settings__Search":[],"Settings__Web":[],"Tvshows__Recent":[],"Browser__Source_String":["{ source : String.String }"],"Playlists__Name_String":["{ name : String.String }"],"Videoplayer__Movieid_Int":["{ movieid : Basics.Int }"],"Music__Top__Top":[],"Settings__Kodi__Games":[],"Settings__Kodi__Interface":[],"Settings__Kodi__Media":[],"Settings__Kodi__Player":[],"Settings__Kodi__Pvr":[],"Settings__Kodi__Services":[],"Settings__Kodi__System":[],"Music__Album__Albumid_Int":["{ albumid : Basics.Int }"],"Music__Artist__Artistid_Int":["{ artistid : Basics.Int }"],"Music__Genre__Genre_String":["{ genre : String.String }"]}},"Basics.Bool":{"args":[],"tags":{"True":[],"False":[]}},"Http.Error":{"args":[],"tags":{"BadUrl":["String.String"],"Timeout":[],"NetworkError":[],"BadStatus":["Basics.Int"],"BadBody":["String.String"]}},"WSDecoder.FileType":{"args":[],"tags":{"Directory":[],"File":[]}},"WSDecoder.PType":{"args":[],"tags":{"Audio":[],"Video":[]}},"WSDecoder.PlayerType":{"args":[],"tags":{"Internal":[],"External":[]}},"Result.Result":{"args":["error","value"],"tags":{"Ok":["value"],"Err":["error"]}}}}})}});

//////////////////// HMR BEGIN ////////////////////

/*
  MIT License http://www.opensource.org/licenses/mit-license.php
  Original Author: Flux Xu @fluxxu
*/

/*
    A note about the environment that this code runs in...

    assumed globals:
        - `module` (from Node.js module system and webpack)

    assumed in scope after injection into the Elm IIFE:
        - `scope` (has an 'Elm' property which contains the public Elm API)
        - various functions defined by Elm which we have to hook such as `_Platform_initialize` and `_Scheduler_binding`
 */

if (module.hot) {
    (function () {
        "use strict";

        //polyfill for IE: https://github.com/fluxxu/elm-hot-loader/issues/16
        if (typeof Object.assign != 'function') {
            Object.assign = function (target) {
                'use strict';
                if (target == null) {
                    throw new TypeError('Cannot convert undefined or null to object');
                }

                target = Object(target);
                for (var index = 1; index < arguments.length; index++) {
                    var source = arguments[index];
                    if (source != null) {
                        for (var key in source) {
                            if (Object.prototype.hasOwnProperty.call(source, key)) {
                                target[key] = source[key];
                            }
                        }
                    }
                }
                return target;
            };
        }

        // Elm 0.19.1 introduced a '$' prefix at the beginning of the symbols it emits,
        // and we check for `Maybe.Just` because we expect it to be present in all Elm programs.
        var elmVersion;
        if (typeof elm$core$Maybe$Just !== 'undefined')
            elmVersion = '0.19.0';
        else if (typeof $elm$core$Maybe$Just !== 'undefined')
            elmVersion = '0.19.1';
        else
            throw new Error("Could not determine Elm version");

        function elmSymbol(symbol) {
            try {
                switch (elmVersion) {
                    case '0.19.0':
                        return eval(symbol);
                    case '0.19.1':
                        return eval('$' + symbol);
                    default:
                        throw new Error('Cannot resolve ' + symbol + '. Elm version unknown!')
                }
            } catch (e) {
                if (e instanceof ReferenceError) {
                    return undefined;
                } else {
                    throw e;
                }
            }
        }

        var instances = module.hot.data
            ? module.hot.data.instances || {}
            : {};
        var uid = module.hot.data
            ? module.hot.data.uid || 0
            : 0;

        if (Object.keys(instances).length === 0) {
            log("[elm-hot] Enabled");
        }

        var cancellers = [];

        // These 2 variables act as dynamically-scoped variables which are set only when the
        // Elm module's hooked init function is called.
        var initializingInstance = null;
        var swappingInstance = null;

        module.hot.accept();
        module.hot.dispose(function (data) {
            data.instances = instances;
            data.uid = uid;

            // Cleanup pending async tasks

            // First, make sure that no new tasks can be started until we finish replacing the code
            _Scheduler_binding = function () {
                return _Scheduler_fail(new Error('[elm-hot] Inactive Elm instance.'))
            };

            // Second, kill pending tasks belonging to the old instance
            if (cancellers.length) {
                log('[elm-hot] Killing ' + cancellers.length + ' running processes...');
                try {
                    cancellers.forEach(function (cancel) {
                        cancel();
                    });
                } catch (e) {
                    console.warn('[elm-hot] Kill process error: ' + e.message);
                }
            }
        });

        function log(message) {
            if (module.hot.verbose) {
                console.log(message)
            }
        }

        function getId() {
            return ++uid;
        }

        function findPublicModules(parent, path) {
            var modules = [];
            for (var key in parent) {
                var child = parent[key];
                var currentPath = path ? path + '.' + key : key;
                if ('init' in child) {
                    modules.push({
                        path: currentPath,
                        module: child
                    });
                } else {
                    modules = modules.concat(findPublicModules(child, currentPath));
                }
            }
            return modules;
        }

        function registerInstance(domNode, flags, path, portSubscribes, portSends) {
            var id = getId();

            var instance = {
                id: id,
                path: path,
                domNode: domNode,
                flags: flags,
                portSubscribes: portSubscribes,
                portSends: portSends,
                lastState: null // last Elm app state (root model)
            };

            return instances[id] = instance
        }

        function isFullscreenApp() {
            // Returns true if the Elm app will take over the entire DOM body.
            return typeof elmSymbol("elm$browser$Browser$application") !== 'undefined'
                || typeof elmSymbol("elm$browser$Browser$document") !== 'undefined';
        }

        function wrapDomNode(node) {
            // When embedding an Elm app into a specific DOM node, Elm will replace the provided
            // DOM node with the Elm app's content. When the Elm app is compiled normally, the
            // original DOM node is reused (its attributes and content changes, but the object
            // in memory remains the same). But when compiled using `--debug`, Elm will completely
            // destroy the original DOM node and instead replace it with 2 brand new nodes: one
            // for your Elm app's content and the other for the Elm debugger UI. In this case,
            // if you held a reference to the DOM node provided for embedding, it would be orphaned
            // after Elm module initialization.
            //
            // So in order to make both cases consistent and isolate us from changes in how Elm
            // does this, we will insert a dummy node to wrap the node for embedding and hold
            // a reference to the dummy node.
            //
            // We will also put a tag on the dummy node so that the Elm developer knows who went
            // behind their back and rudely put stuff in their DOM.
            var dummyNode = document.createElement("div");
            dummyNode.setAttribute("data-elm-hot", "true");
            dummyNode.style.height = "inherit";
            var parentNode = node.parentNode;
            parentNode.replaceChild(dummyNode, node);
            dummyNode.appendChild(node);
            return dummyNode;
        }

        function wrapPublicModule(path, module) {
            var originalInit = module.init;
            if (originalInit) {
                module.init = function (args) {
                    var elm;
                    var portSubscribes = {};
                    var portSends = {};
                    var domNode = null;
                    var flags = null;
                    if (typeof args !== 'undefined') {
                        // normal case
                        domNode = args['node'] && !isFullscreenApp()
                            ? wrapDomNode(args['node'])
                            : document.body;
                        flags = args['flags'];
                    } else {
                        // rare case: Elm allows init to be called without any arguments at all
                        domNode = document.body;
                        flags = undefined
                    }
                    initializingInstance = registerInstance(domNode, flags, path, portSubscribes, portSends);
                    elm = originalInit(args);
                    wrapPorts(elm, portSubscribes, portSends);
                    initializingInstance = null;
                    return elm;
                };
            } else {
                console.error("Could not find a public module to wrap at path " + path)
            }
        }

        function swap(Elm, instance) {
            log('[elm-hot] Hot-swapping module: ' + instance.path);

            swappingInstance = instance;

            // remove from the DOM everything that had been created by the old Elm app
            var containerNode = instance.domNode;
            while (containerNode.lastChild) {
                containerNode.removeChild(containerNode.lastChild);
            }

            var m = getAt(instance.path.split('.'), Elm);
            var elm;
            if (m) {
                // prepare to initialize the new Elm module
                var args = {flags: instance.flags};
                if (containerNode === document.body) {
                    // fullscreen case: no additional args needed
                } else {
                    // embed case: provide a new node for Elm to use
                    var nodeForEmbed = document.createElement("div");
                    containerNode.appendChild(nodeForEmbed);
                    args['node'] = nodeForEmbed;
                }

                elm = m.init(args);

                Object.keys(instance.portSubscribes).forEach(function (portName) {
                    if (portName in elm.ports && 'subscribe' in elm.ports[portName]) {
                        var handlers = instance.portSubscribes[portName];
                        if (!handlers.length) {
                            return;
                        }
                        log('[elm-hot] Reconnect ' + handlers.length + ' handler(s) to port \''
                            + portName + '\' (' + instance.path + ').');
                        handlers.forEach(function (handler) {
                            elm.ports[portName].subscribe(handler);
                        });
                    } else {
                        delete instance.portSubscribes[portName];
                        log('[elm-hot] Port was removed: ' + portName);
                    }
                });

                Object.keys(instance.portSends).forEach(function (portName) {
                    if (portName in elm.ports && 'send' in elm.ports[portName]) {
                        log('[elm-hot] Replace old port send with the new send');
                        instance.portSends[portName] = elm.ports[portName].send;
                    } else {
                        delete instance.portSends[portName];
                        log('[elm-hot] Port was removed: ' + portName);
                    }
                });
            } else {
                log('[elm-hot] Module was removed: ' + instance.path);
            }

            swappingInstance = null;
        }

        function wrapPorts(elm, portSubscribes, portSends) {
            var portNames = Object.keys(elm.ports || {});
            //hook ports
            if (portNames.length) {
                // hook outgoing ports
                portNames
                    .filter(function (name) {
                        return 'subscribe' in elm.ports[name];
                    })
                    .forEach(function (portName) {
                        var port = elm.ports[portName];
                        var subscribe = port.subscribe;
                        var unsubscribe = port.unsubscribe;
                        elm.ports[portName] = Object.assign(port, {
                            subscribe: function (handler) {
                                log('[elm-hot] ports.' + portName + '.subscribe called.');
                                if (!portSubscribes[portName]) {
                                    portSubscribes[portName] = [handler];
                                } else {
                                    //TODO handle subscribing to single handler more than once?
                                    portSubscribes[portName].push(handler);
                                }
                                return subscribe.call(port, handler);
                            },
                            unsubscribe: function (handler) {
                                log('[elm-hot] ports.' + portName + '.unsubscribe called.');
                                var list = portSubscribes[portName];
                                if (list && list.indexOf(handler) !== -1) {
                                    list.splice(list.lastIndexOf(handler), 1);
                                } else {
                                    console.warn('[elm-hot] ports.' + portName + '.unsubscribe: handler not subscribed');
                                }
                                return unsubscribe.call(port, handler);
                            }
                        });
                    });

                // hook incoming ports
                portNames
                    .filter(function (name) {
                        return 'send' in elm.ports[name];
                    })
                    .forEach(function (portName) {
                        var port = elm.ports[portName];
                        portSends[portName] = port.send;
                        elm.ports[portName] = Object.assign(port, {
                            send: function (val) {
                                return portSends[portName].call(port, val);
                            }
                        });
                    });
            }
            return portSubscribes;
        }

        /*
        Breadth-first search for a `Browser.Navigation.Key` in the user's app model.
        Returns the key and keypath or null if not found.
        */
        function findNavKey(rootModel) {
            var queue = [];
            if (isDebuggerModel(rootModel)) {
                /*
                 Extract the user's app model from the Elm Debugger's model. The Elm debugger
                 can hold multiple references to the user's model (e.g. in its "history"). So
                 we must be careful to only search within the "state" part of the Debugger.
                */
                queue.push({value: rootModel['state'], keypath: ['state']});
            } else {
                queue.push({value: rootModel, keypath: []});
            }

            while (queue.length !== 0) {
                var item = queue.shift();

                if (typeof item.value === "undefined" || item.value === null) {
                    continue;
                }

                // The nav key is identified by a runtime tag added by the elm-hot injector.
                if (item.value.hasOwnProperty("elm-hot-nav-key")) {
                    // found it!
                    return item;
                }

                if (typeof item.value !== "object") {
                    continue;
                }

                for (var propName in item.value) {
                    if (!item.value.hasOwnProperty(propName)) continue;
                    var newKeypath = item.keypath.slice();
                    newKeypath.push(propName);
                    queue.push({value: item.value[propName], keypath: newKeypath})
                }
            }

            return null;
        }


        function isDebuggerModel(model) {
            // Up until elm/browser 1.0.2, the Elm debugger could be identified by a
            // property named "expando". But in version 1.0.2 that was renamed to "expandoModel"
            return model
                && (model.hasOwnProperty("expando") || model.hasOwnProperty("expandoModel"))
                && model.hasOwnProperty("state");
        }

        function getAt(keyPath, obj) {
            return keyPath.reduce(function (xs, x) {
                return (xs && xs[x]) ? xs[x] : null
            }, obj)
        }

        function removeNavKeyListeners(navKey) {
            window.removeEventListener('popstate', navKey.value);
            window.navigator.userAgent.indexOf('Trident') < 0 || window.removeEventListener('hashchange', navKey.value);
        }

        // hook program creation
        var initialize = _Platform_initialize;
        _Platform_initialize = function (flagDecoder, args, init, update, subscriptions, stepperBuilder) {
            var instance = initializingInstance || swappingInstance;
            var tryFirstRender = !!swappingInstance;

            var hookedInit = function (args) {
                var initialStateTuple = init(args);
                if (swappingInstance) {
                    var oldModel = swappingInstance.lastState;
                    var newModel = initialStateTuple.a;

                    if (typeof elmSymbol("elm$browser$Browser$application") !== 'undefined') {
                        var oldKeyLoc = findNavKey(oldModel);

                        // attempt to find the Browser.Navigation.Key in the newly-constructed model
                        // and bring it along with the rest of the old data.
                        var newKeyLoc = findNavKey(newModel);
                        var error = null;
                        if (newKeyLoc === null) {
                            error = "could not find Browser.Navigation.Key in the new app model";
                        } else if (oldKeyLoc === null) {
                            error = "could not find Browser.Navigation.Key in the old app model.";
                        } else if (newKeyLoc.keypath.toString() !== oldKeyLoc.keypath.toString()) {
                            error = "the location of the Browser.Navigation.Key in the model has changed.";
                        } else {
                            // remove event listeners attached to the old nav key
                            removeNavKeyListeners(oldKeyLoc.value);

                            // insert the new nav key into the old model in the exact same location
                            var parentKeyPath = oldKeyLoc.keypath.slice(0, -1);
                            var lastSegment = oldKeyLoc.keypath.slice(-1)[0];
                            var oldParent = getAt(parentKeyPath, oldModel);
                            oldParent[lastSegment] = newKeyLoc.value;
                        }

                        if (error !== null) {
                            console.error("[elm-hot] Hot-swapping " + instance.path + " not possible: " + error);
                            oldModel = newModel;
                        }
                    }

                    // the heart of the app state hot-swap
                    initialStateTuple.a = oldModel;

                    // ignore any Cmds returned by the init during hot-swap
                    initialStateTuple.b = elmSymbol("elm$core$Platform$Cmd$none");
                } else {
                    // capture the initial state for later
                    initializingInstance.lastState = initialStateTuple.a;
                }

                return initialStateTuple
            };

            var hookedStepperBuilder = function (sendToApp, model) {
                var result;
                // first render may fail if shape of model changed too much
                if (tryFirstRender) {
                    tryFirstRender = false;
                    try {
                        result = stepperBuilder(sendToApp, model)
                    } catch (e) {
                        throw new Error('[elm-hot] Hot-swapping ' + instance.path +
                            ' is not possible, please reload page. Error: ' + e.message)
                    }
                } else {
                    result = stepperBuilder(sendToApp, model)
                }

                return function (nextModel, isSync) {
                    if (instance) {
                        // capture the state after every step so that later we can restore from it during a hot-swap
                        instance.lastState = nextModel
                    }
                    return result(nextModel, isSync)
                }
            };

            return initialize(flagDecoder, args, hookedInit, update, subscriptions, hookedStepperBuilder)
        };

        // hook process creation
        var originalBinding = _Scheduler_binding;
        _Scheduler_binding = function (originalCallback) {
            return originalBinding(function () {
                // start the scheduled process, which may return a cancellation function.
                var cancel = originalCallback.apply(this, arguments);
                if (cancel) {
                    cancellers.push(cancel);
                    return function () {
                        cancellers.splice(cancellers.indexOf(cancel), 1);
                        return cancel();
                    };
                }
                return cancel;
            });
        };

        scope['_elm_hot_loader_init'] = function (Elm) {
            // swap instances
            var removedInstances = [];
            for (var id in instances) {
                var instance = instances[id];
                if (instance.domNode.parentNode) {
                    swap(Elm, instance);
                } else {
                    removedInstances.push(id);
                }
            }

            removedInstances.forEach(function (id) {
                delete instance[id];
            });

            // wrap all public modules
            var publicModules = findPublicModules(Elm);
            publicModules.forEach(function (m) {
                wrapPublicModule(m.path, m.module);
            });
        }
    })();

    scope['_elm_hot_loader_init'](scope['Elm']);
}
//////////////////// HMR END ////////////////////


}(this));
},{}],"main.js":[function(require,module,exports) {
"use strict";

var _Main = require("../src/Main.elm");

//@ts-check
document.addEventListener("DOMContentLoaded", function () {
  // Initial data passed to Elm (should match `Flags` defined in `Shared.elm`)
  // https://guide.elm-lang.org/interop/flags.html
  var storedData = localStorage.getItem('kodiLocalPlaylists');
  var flags = {
    innerWidth: window.innerWidth,
    innerHeight: window.innerHeight,
    localPlaylists: storedData ? storedData : null
  }; // Start our Elm application

  var app = _Main.Elm.Main.init({
    node: document.querySelector("main"),
    flags: flags
  });

  var ws = new WebSocket("ws://localhost:9090");

  ws.onopen = function () {
    app.ports.connection.send("Connected"); // When a command goes to the `sendMessage` port, we pass the message
    // along to the WebSocket.

    app.ports.sendActions.subscribe(function (action) {
      var actionListLength = action.length;

      for (var i = 0; i < actionListLength; i++) {
        ws.send(action[i]); //console.log(action[i]);
      }
    }); // When a message comes into our WebSocket, we pass the message along
    // to the `messageReceiver` port.

    ws.addEventListener("message", function (event) {
      app.ports.responseReceiver.send(event.data);
      console.log(event.data);
    }); // Ports go here
    // https://guide.elm-lang.org/interop/ports.html
  };

  ws.onerror = function (event) {
    app.ports.connection.send("Disconnected");
  };

  window.onbeforeunload = function () {
    app.ports.connection.send("Disconnected");
    ws.close();
  }; // Listen for commands from the `setStorage` port.
  // Turn the data to a string and put it in localStorage.


  app.ports.setStorage.subscribe(function (playlists) {
    localStorage.setItem('kodiLocalPlaylists', playlists);
  });
});
},{"../src/Main.elm":"../src/Main.elm"}],"../node_modules/parcel-bundler/src/builtins/hmr-runtime.js":[function(require,module,exports) {
var global = arguments[3];
var OVERLAY_ID = '__parcel__error__overlay__';
var OldModule = module.bundle.Module;

function Module(moduleName) {
  OldModule.call(this, moduleName);
  this.hot = {
    data: module.bundle.hotData,
    _acceptCallbacks: [],
    _disposeCallbacks: [],
    accept: function (fn) {
      this._acceptCallbacks.push(fn || function () {});
    },
    dispose: function (fn) {
      this._disposeCallbacks.push(fn);
    }
  };
  module.bundle.hotData = null;
}

module.bundle.Module = Module;
var checkedAssets, assetsToAccept;
var parent = module.bundle.parent;

if ((!parent || !parent.isParcelRequire) && typeof WebSocket !== 'undefined') {
  var hostname = "" || location.hostname;
  var protocol = location.protocol === 'https:' ? 'wss' : 'ws';
  var ws = new WebSocket(protocol + '://' + hostname + ':' + "45717" + '/');

  ws.onmessage = function (event) {
    checkedAssets = {};
    assetsToAccept = [];
    var data = JSON.parse(event.data);

    if (data.type === 'update') {
      var handled = false;
      data.assets.forEach(function (asset) {
        if (!asset.isNew) {
          var didAccept = hmrAcceptCheck(global.parcelRequire, asset.id);

          if (didAccept) {
            handled = true;
          }
        }
      }); // Enable HMR for CSS by default.

      handled = handled || data.assets.every(function (asset) {
        return asset.type === 'css' && asset.generated.js;
      });

      if (handled) {
        console.clear();
        data.assets.forEach(function (asset) {
          hmrApply(global.parcelRequire, asset);
        });
        assetsToAccept.forEach(function (v) {
          hmrAcceptRun(v[0], v[1]);
        });
      } else if (location.reload) {
        // `location` global exists in a web worker context but lacks `.reload()` function.
        location.reload();
      }
    }

    if (data.type === 'reload') {
      ws.close();

      ws.onclose = function () {
        location.reload();
      };
    }

    if (data.type === 'error-resolved') {
      console.log('[parcel] ✨ Error resolved');
      removeErrorOverlay();
    }

    if (data.type === 'error') {
      console.error('[parcel] 🚨  ' + data.error.message + '\n' + data.error.stack);
      removeErrorOverlay();
      var overlay = createErrorOverlay(data);
      document.body.appendChild(overlay);
    }
  };
}

function removeErrorOverlay() {
  var overlay = document.getElementById(OVERLAY_ID);

  if (overlay) {
    overlay.remove();
  }
}

function createErrorOverlay(data) {
  var overlay = document.createElement('div');
  overlay.id = OVERLAY_ID; // html encode message and stack trace

  var message = document.createElement('div');
  var stackTrace = document.createElement('pre');
  message.innerText = data.error.message;
  stackTrace.innerText = data.error.stack;
  overlay.innerHTML = '<div style="background: black; font-size: 16px; color: white; position: fixed; height: 100%; width: 100%; top: 0px; left: 0px; padding: 30px; opacity: 0.85; font-family: Menlo, Consolas, monospace; z-index: 9999;">' + '<span style="background: red; padding: 2px 4px; border-radius: 2px;">ERROR</span>' + '<span style="top: 2px; margin-left: 5px; position: relative;">🚨</span>' + '<div style="font-size: 18px; font-weight: bold; margin-top: 20px;">' + message.innerHTML + '</div>' + '<pre>' + stackTrace.innerHTML + '</pre>' + '</div>';
  return overlay;
}

function getParents(bundle, id) {
  var modules = bundle.modules;

  if (!modules) {
    return [];
  }

  var parents = [];
  var k, d, dep;

  for (k in modules) {
    for (d in modules[k][1]) {
      dep = modules[k][1][d];

      if (dep === id || Array.isArray(dep) && dep[dep.length - 1] === id) {
        parents.push(k);
      }
    }
  }

  if (bundle.parent) {
    parents = parents.concat(getParents(bundle.parent, id));
  }

  return parents;
}

function hmrApply(bundle, asset) {
  var modules = bundle.modules;

  if (!modules) {
    return;
  }

  if (modules[asset.id] || !bundle.parent) {
    var fn = new Function('require', 'module', 'exports', asset.generated.js);
    asset.isNew = !modules[asset.id];
    modules[asset.id] = [fn, asset.deps];
  } else if (bundle.parent) {
    hmrApply(bundle.parent, asset);
  }
}

function hmrAcceptCheck(bundle, id) {
  var modules = bundle.modules;

  if (!modules) {
    return;
  }

  if (!modules[id] && bundle.parent) {
    return hmrAcceptCheck(bundle.parent, id);
  }

  if (checkedAssets[id]) {
    return;
  }

  checkedAssets[id] = true;
  var cached = bundle.cache[id];
  assetsToAccept.push([bundle, id]);

  if (cached && cached.hot && cached.hot._acceptCallbacks.length) {
    return true;
  }

  return getParents(global.parcelRequire, id).some(function (id) {
    return hmrAcceptCheck(global.parcelRequire, id);
  });
}

function hmrAcceptRun(bundle, id) {
  var cached = bundle.cache[id];
  bundle.hotData = {};

  if (cached) {
    cached.hot.data = bundle.hotData;
  }

  if (cached && cached.hot && cached.hot._disposeCallbacks.length) {
    cached.hot._disposeCallbacks.forEach(function (cb) {
      cb(bundle.hotData);
    });
  }

  delete bundle.cache[id];
  bundle(id);
  cached = bundle.cache[id];

  if (cached && cached.hot && cached.hot._acceptCallbacks.length) {
    cached.hot._acceptCallbacks.forEach(function (cb) {
      cb();
    });

    return true;
  }
}
},{}]},{},["../node_modules/parcel-bundler/src/builtins/hmr-runtime.js","main.js"], null)
//# sourceMappingURL=/main.1f19ae8e.js.map