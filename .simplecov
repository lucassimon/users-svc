SimpleCov.start 'rails' do
  add_filter do |source_file|
    source_file.lines.count < 3
  end

  maximum_coverage_drop 1
end
