# # https://www.ncbi.nlm.nih.gov/Structure/cdd/cdd.shtml

CDD.fetchDescription <- function(id) {
  ncbicdd <- "https://www.ncbi.nlm.nih.gov/Structure/cdd/"
  cdtitle <- xml2::xml_text(
    xml2::xml_find_first(
      x = xml2::read_html(
        httr::GET(
          paste0(ncbicdd, id)
        )
      ),
      xpath = "/html/head/title"
    )
  )
  cddescription <- xml2::xml_text(
    xml2::xml_find_first(
      x = xml2::read_html(
        httr::GET(
          paste0(ncbicdd, id)
        )
      ),
      xpath = "//*[@id='description']"
    )
  )

  return(
    data.frame(
      cdd_description = cddescription,
      cdd_short_description = gsub(
        "CDD Conserved Protein Domain Family: ", "", cdtitle
      )
    )
  )
}
