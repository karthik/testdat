detect_cap = function(char){
  uniques = unique(char)
  lower_uniques = tolower(uniques)
  
  matches = names(which(table(lower_uniques) > 1))
  
  
  if(length(matches) > 0){
    message("The following sets of elements are identical except for capitalization")
    lapply(
      matches, 
      function(x){
        uniques[x == lower_uniques]
      }
    )
  }
}


# I defaulted to Jaccard similarity because it's pre-scaled.  It's probably not
# the best distance metric for this though!
detect_similar = function(char, method = "jaccard", tol = 0.1, ...){
  uniques = unique(char)
  distmat = stringdistmatrix(uniques, uniques, method = method, ...)
  
  indices = which(distmat < tol & upper.tri(distmat))
  
  message("The following pairs of elements were uncomfortably similar")
  
  # Could do something fancy like grouping them together (not just pairs) & 
  # indicating which name is more common.
  
  #Column names aren't meaningful
  data.frame(
    a = uniques[row(distmat)[indices]], 
    b = uniques[col(distmat)[indices]]
  )
  
}
