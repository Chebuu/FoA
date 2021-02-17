# #' @title Package base class
# #' @export
# setClass(
#   "Identifier",
#   slots = c(
#     id = "character",
#     bit = "logical"
#   ),
#   contains = c("character")
# )

# #' @title Base ID container
# #' @export
# setClass(
#   "Fid",
#   slots = c(
#     id = "character"
#   ),
#   contains = c("Identifier")
# )

# #' @title Entrez ID container
# #' @export
# setClass(
#   "Entrez",
#   contains = c("Fid")
# )

# #' @title UniProtKB ID container
# #' @export
# setClass(
#   "UniProtKB",
#   contains = c("Fid")
# )
