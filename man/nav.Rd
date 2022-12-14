% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nav-items.R
\name{nav}
\alias{nav}
\alias{nav_menu}
\alias{nav_content}
\alias{nav_item}
\alias{nav_spacer}
\title{Navigation items}
\usage{
nav(title, ..., value = title, icon = NULL)

nav_menu(title, ..., value = title, icon = NULL, align = c("left", "right"))

nav_content(value, ..., icon = NULL)

nav_item(...)

nav_spacer()
}
\arguments{
\item{title}{A title to display. Can be a character string or UI elements
(i.e., \link{tags}).}

\item{...}{Depends on the function:
\itemize{
\item For \code{nav()} and \code{nav_content()}: UI elements (i.e., \link{tags}) to display
when the item is active.
\item For \code{nav_menu()}: a collection of nav items (e.g., \code{nav()}, \code{nav_item()}).
\item For \code{nav_item()}: UI elements (i.e., \link{tags}) to place directly in
the navigation panel (e.g., search forms, links to external content, etc).
}}

\item{value}{A character string to assign to the nav item. This value may be
supplied to the relevant container's \code{selected} argument in order to show
particular nav item's content immediately on page load. This value is also
useful for programmatically updating the selected content via
\code{\link[=nav_select]{nav_select()}}, \code{\link[=nav_hide]{nav_hide()}}, etc (updating selected tabs this way is often
useful for showing/hiding panels of content via other UI controls like
\code{\link[shiny:radioButtons]{shiny::radioButtons()}} -- in this scenario, consider using \code{\link[=nav_content]{nav_content()}}
with \code{\link[=navs_hidden]{navs_hidden()}}).}

\item{icon}{Optional icon to appear next to the nav item's \code{title}.}

\item{align}{horizontal alignment of the dropdown menu relative to dropdown toggle.}
}
\value{
A nav item that may be passed to a nav container (e.g. \code{\link[=navs_tab]{navs_tab()}}).
}
\description{
Create nav item(s) for use inside nav containers (e.g., \code{\link[=navs_tab]{navs_tab()}},
\code{\link[=navs_bar]{navs_bar()}}, etc).
}
\section{Functions}{
\itemize{
\item \code{nav()}: Content to display when the given item is selected.

\item \code{nav_menu()}: Create a menu of nav items.

\item \code{nav_content()}: Create nav content for use inside \code{navs_hidden()} (for
creating custom navigation controls via \code{navs_select()}),

\item \code{nav_item()}: Place arbitrary content in the navigation panel (e.g., search
forms, links to external content, etc.)

\item \code{nav_spacer()}: Adding spacing between nav items.

}}
\seealso{
\code{\link[=navs_tab]{navs_tab()}}, \code{\link[=nav_select]{nav_select()}}.
}
