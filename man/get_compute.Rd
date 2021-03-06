% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute.R
\name{get_compute}
\alias{get_compute}
\title{Get an existing compute cluster}
\usage{
get_compute(workspace, cluster_name)
}
\arguments{
\item{workspace}{The \code{Workspace} object.}

\item{cluster_name}{A string of the name of the cluster.}
}
\value{
The \code{AmlCompute} or \code{AksCompute} object.
}
\description{
Returns an \code{AmlCompute} or \code{AksCompute} object for an existing compute
resource. If the compute target doesn't exist, the function will return
\code{NULL}.
}
\examples{
\dontrun{
ws <- load_workspace_from_config()
compute_target <- get_compute(ws, cluster_name = 'mycluster')
}
}
