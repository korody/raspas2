$(function() {

  $("#raspa_tag_tokens").tokenInput("/tags.json", {
    crossDomain: false,
    prePopulate: $("#raspa_tag_tokens").data("load"),
    theme: "facebook",
    preventDuplicates: true
  });

  $("#origin_author_tokens").tokenInput("/authors.json", {
    crossDomain: false,
    prePopulate: $("#origin_author_tokens").data("load"),
    theme: "facebook",
    preventDuplicates: true
  });

  $("#origin_genre_tokens").tokenInput("/genres.json", {
    crossDomain: false,
    prePopulate: $("#origin_genre_tokens").data("load"),
    theme: "facebook",
    preventDuplicates: true
  });

  $("#user_profile_author_attributes_job_tokens").tokenInput("/jobs.json", {
    crossDomain: false,
    prePopulate: $("#user_profile_author_attributes_job_tokens").data("load"),
    theme: "facebook",
    preventDuplicates: true
  });

});