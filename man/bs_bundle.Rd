% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bs-theme-layers.R
\name{bs_add_variables}
\alias{bs_add_variables}
\alias{bs_add_rules}
\alias{bs_add_functions}
\alias{bs_add_mixins}
\alias{bs_bundle}
\title{Add low-level theming customizations}
\usage{
bs_add_variables(
  theme,
  ...,
  .where = "defaults",
  .default_flag = identical(.where, "defaults")
)

bs_add_rules(theme, rules)

bs_add_functions(theme, functions)

bs_add_mixins(theme, mixins)

bs_bundle(theme, ...)
}
\arguments{
\item{theme}{a \code{\link[=bs_theme]{bs_theme()}} object.}

\item{...}{\itemize{
\item \code{bs_add_variables()}: Should be named Sass variables or values that can be passed in directly to the \code{defaults} argument of a \code{\link[sass:sass_layer]{sass::sass_layer()}}.
\item \code{bs_bundle()}: Should be arguments that can be handled by \code{\link[sass:sass_layer]{sass::sass_bundle()}} to be appended to the \code{theme}
}}

\item{.where}{Whether to place the variable definitions before other Sass
\code{"defaults"}, after other Sass \code{"declarations"}, or after other Sass
\code{"rules"}.}

\item{.default_flag}{Whether or not to add a \code{!default} flag (if missing) to
variable expressions. It's recommended to keep this as \code{TRUE} when \code{.where = "defaults"}.}

\item{rules}{Sass rules. Anything understood by \code{\link[sass:as_sass]{sass::as_sass()}} may be
provided (e.g., a list, character vector, \code{\link[sass:sass_import]{sass::sass_file()}}, etc)}

\item{functions}{A character vector or \code{\link[sass:sass_import]{sass::sass_file()}} containing
functions definitions.}

\item{mixins}{A character vector or \code{\link[sass:sass_import]{sass::sass_file()}} containing
mixin definitions.}
}
\value{
a modified \code{\link[=bs_theme]{bs_theme()}} object.
}
\description{
Compared to higher-level theme customization available in \code{\link[=bs_theme]{bs_theme()}}, these functions
are a more direct interface to Bootstrap Sass, and therefore, do nothing to
ensure theme customizations are portable between major Bootstrap versions.
}
\section{Functions}{
\itemize{
\item \code{bs_add_variables()}: Add Bootstrap Sass \href{https://getbootstrap.com/docs/4.4/getting-started/theming/#variable-defaults}{variable defaults}

\item \code{bs_add_rules()}: Add additional \href{https://sass-lang.com/documentation/style-rules}{Sass rules}

\item \code{bs_add_functions()}: Add additional \href{https://rstudio.github.io/sass/articles/sass.html#functions-1}{Sass functions}

\item \code{bs_add_mixins()}: Add additional \href{https://rstudio.github.io/sass/articles/sass.html#mixins-1}{Sass mixins}

\item \code{bs_bundle()}: Add additional \code{\link[sass:sass_layer]{sass::sass_bundle()}} objects to an existing \code{theme}.

}}
\examples{

# Function to preview the styling a (primary) Bootstrap button
library(htmltools)
button <- tags$a(class = "btn btn-primary", href = "#", role = "button", "Hello")
preview_button <- function(theme) {
  if (interactive()) {
    browsable(tags$body(bs_theme_dependencies(theme), button))
  }
}

# Here we start with a theme based on a Bootswatch theme,
# then override some variable defaults
theme <- bs_add_variables(
  bs_theme(bootswatch = "sketchy", primary = "orange"),
  "body-bg" = "#EEEEEE",
  "font-family-base" = "monospace",
  "font-size-base" = "1.4rem",
  "btn-padding-y" = ".16rem",
  "btn-padding-x" = "2rem"
)

preview_button(theme)

# If you need to set a variable based on another Bootstrap variable
theme <- bs_add_variables(theme, "body-color" = "$success", .where = "declarations")
preview_button(theme)

# Start a new global theme and add some custom rules that
# use Bootstrap variables to define a custom styling for a
# 'person card'
person_rules <- system.file("custom", "person.scss", package = "bslib")
theme <- bs_add_rules(bs_theme(), sass::sass_file(person_rules))
# Include custom CSS that leverages bootstrap Sass variables
person <- function(name, title, company) {
  tags$div(
    class = "person",
    h3(class = "name", name),
    div(class = "title", title),
    div(class = "company", company)
  )
}
if (interactive()) {
  browsable(shiny::fluidPage(
    theme = theme,
    person("Andrew Carnegie", "Owner", "Carnegie Steel Company"),
    person("John D. Rockefeller", "Chairman", "Standard Oil")
  ))
}

}
\references{
\url{https://getbootstrap.com/docs/4.4/getting-started/theming/}

\url{https://rstudio.github.io/sass/articles/sass.html#layering}
}
