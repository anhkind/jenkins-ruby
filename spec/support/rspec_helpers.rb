module RSpecHelpers
  def file(filename)
    File.join(SPEC_ROOT, "fixtures", "files", filename)
  end
end