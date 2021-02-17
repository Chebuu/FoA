setClass(
	"Hello",
	slots = c(
		salutation = class("character")
	),
	prototype = list(
	  salutation = "Hello, world!"
	),
	validity = function(object) {
	  echo("CUNT")
		ojects("object")
	},
  contains = c("character")
)

(new("Hello"))

#' `echo`
#' @  https://www.tidyverse.org/blog/2018/11/generics-0.0.1/
#' @export
setGeneric(
	name = "echo",
	def = function(...) {
	  message(cat(...))
	}
)

setMethod(
	"echo",
	signature("character"),
	function(...) {
	  callGeneric(...)
	}
)

setMethod(
  "echo",
  signature("numeric"),
  function(...) {
    callNextMethod(...)
  }
)

setMethod(
	"echo",
	signature("NULL"),
	function(...) {
	  message(...)
	}
)


