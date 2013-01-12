module RSpecHelpers
  def content(file_path)
    File.read(file_path)
  end

  def file(filename)
    File.join(SPEC_ROOT, "fixtures", "files", filename)
  end

  def vcr(name)
    VCR.use_cassette(name) do
      yield
    end
  end
end