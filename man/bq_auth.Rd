% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bq-auth.R
\name{bq_auth}
\alias{bq_auth}
\title{Authorize bigrquery}
\usage{
bq_auth(
  email = gargle::gargle_oauth_email(),
  path = NULL,
  scopes = c("https://www.googleapis.com/auth/bigquery",
    "https://www.googleapis.com/auth/cloud-platform"),
  cache = gargle::gargle_oauth_cache(),
  use_oob = gargle::gargle_oob_default(),
  token = NULL
)
}
\arguments{
\item{email}{Optional. Allows user to target a specific Google identity. If
specified, this is used for token lookup, i.e. to determine if a suitable
token is already available in the cache. If no such token is found, \code{email}
is used to pre-select the targetted Google identity in the OAuth chooser.
Note, however, that the email associated with a token when it's cached is
always determined from the token itself, never from this argument. Use \code{NA}
or \code{FALSE} to match nothing and force the OAuth dance in the browser. Use
\code{TRUE} to allow email auto-discovery, if exactly one matching token is
found in the cache. Specify just the domain with a glob pattern, e.g.
\code{"*@example.com"}, to create code that "just works" for both
\code{alice@example.com} and \code{bob@example.com}. Defaults to the option named
"gargle_oauth_email", retrieved by \code{\link[gargle:gargle_oauth_email]{gargle_oauth_email()}}.}

\item{path}{JSON identifying the service account, in one of the forms
supported for the \code{txt} argument of \code{\link[jsonlite:fromJSON]{jsonlite::fromJSON()}} (typically, a
file path or JSON string).}

\item{scopes}{A character vector of scopes to request.
Pick from those listed at \url{https://developers.google.com/identity/protocols/oauth2/scopes}.}

\item{cache}{Specifies the OAuth token cache. Defaults to the option named
"gargle_oauth_cache", retrieved via \code{\link[gargle:gargle_oauth_cache]{gargle_oauth_cache()}}.}

\item{use_oob}{Whether to prefer "out of band" authentication. Defaults to
the option named "gargle_oob_default", retrieved via
\code{\link[gargle:gargle_oob_default]{gargle_oob_default()}}.}

\item{token}{A token with class \link[httr:Token-class]{Token2.0} or an object of
httr's class \code{request}, i.e. a token that has been prepared with
\code{\link[httr:config]{httr::config()}} and has a \link[httr:Token-class]{Token2.0} in the
\code{auth_token} component.}
}
\description{
Authorize bigrquery to view and manage your BigQuery projects. This function is a
wrapper around \code{\link[gargle:token_fetch]{gargle::token_fetch()}}.

By default, you are directed to a web browser, asked to sign in to your
Google account, and to grant bigrquery permission to operate on your
behalf with Google BigQuery. By default, with your permission, these user
credentials are cached in a folder below your home directory, from where
they can be automatically refreshed, as necessary. Storage at the user
level means the same token can be used across multiple projects and
tokens are less likely to be synced to the cloud by accident.

If you are interacting with R within a browser (applies to RStudio Server,
RStudio Workbench, and RStudio Cloud), you need a variant of this flow,
known as out-of-band auth ("oob"). If this does not happen
automatically, you can request it yourself with \code{use_oob = TRUE} or,
more persistently, by setting an option via
\code{options(gargle_oob_default = TRUE)}.
}
\details{
Most users, most of the time, do not need to call \code{bq_auth()}
explicitly -- it is triggered by the first action that requires
authorization. Even when called, the default arguments often suffice.
However, when necessary, this function allows the user to explicitly:
\itemize{
\item Declare which Google identity to use, via an email address. If there
are multiple cached tokens, this can clarify which one to use. It can
also force bigrquery to switch from one identity to another. If
there's no cached token for the email, this triggers a return to the
browser to choose the identity and give consent. You can specify just
the domain by using a glob pattern. This means that a script
containing \code{email = "*@example.com"} can be run without further
tweaks on the machine of either \code{alice@example.com} or
\code{bob@example.com}.
\item Use a service account token or workload identity federation.
\item Bring their own \link[httr:Token-class]{Token2.0}.
\item Specify non-default behavior re: token caching and out-of-bound
authentication.
\item Customize scopes.
}

For details on the many ways to find a token, see
\code{\link[gargle:token_fetch]{gargle::token_fetch()}}. For deeper control over auth, use
\code{\link[=bq_auth_configure]{bq_auth_configure()}} to bring your own OAuth app or API key.
Read more about gargle options, see \link[gargle:gargle_options]{gargle::gargle_options}.
}
\examples{
\dontrun{
## load/refresh existing credentials, if available
## otherwise, go to browser for authentication and authorization
bq_auth()

## force use of a token associated with a specific email
bq_auth(email = "jenny@example.com")

## force a menu where you can choose from existing tokens or
## choose to get a new one
bq_auth(email = NA)

## use a 'read only' scope, so it's impossible to change data
bq_auth(
  scopes = "https://www.googleapis.com/auth/devstorage.read_only"
)

## use a service account token
bq_auth(path = "foofy-83ee9e7c9c48.json")
}
}
\seealso{
Other auth functions: 
\code{\link{bq_auth_configure}()},
\code{\link{bq_deauth}()}
}
\concept{auth functions}
