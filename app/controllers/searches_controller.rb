class SearchesController < ApplicationController

  def index
    model = params[:model]
    if model == "Message"
      options = params.merge(:recipient => current_person)
    else
      options = params
    end
    @results = model.constantize.search(options)
    if model == "ForumPost" and @results
      # Cosolidate the topics, eliminating duplicates.
      # TODO: do this in the Topic model.  This will probably require some
      #       search-engine specific hacking, so defer to the time when we're
      #       ready to switch to Sphinx.
      @results = @results.map(&:topic).uniq.paginate
    end
  end
end
