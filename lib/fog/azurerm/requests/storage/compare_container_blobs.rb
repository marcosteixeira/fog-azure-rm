module Fog
  module AzureRM
    class Storage
      # This class provides the actual implementation for service calls.
      class Real
        def compare_container_blobs(container1, container2)
          msg = "Comparing blobs from container #{container1} to container #{container2}"
          Fog::Logger.debug msg
          begin
            identical_blobs = get_identical_blobs_from_containers(container1, container2)
          rescue Azure::Core::Http::HTTPError => ex
            raise_azure_exception(ex, msg)
          end
          identical_blobs
        end

        private

        def get_identical_blobs_from_containers(container1, container2)
          container1_blobs = list_blobs(container1)
          container2_blobs = list_blobs(container2)

          identical_blobs = []
          container1_blobs[:blobs].each do |container1_blob|
            container2_blobs[:blobs].each do |container2_blob|
              if container1_blob.name == container2_blob.name && container1_blob.properties[:content_md5] == container2_blob.properties[:content_md5]
                identical_blobs.push(container1_blob)
              end
            end
          end
          identical_blobs
        end
      end

      # This class provides the mock implementation for unit tests.
      class Mock
        def compare_container_blobs(*)
          [
            {
              'name' => 'test_blob1',
              'metadata' => {},
              'properties' => {
                'last_modified' => 'Mon, 04 Jul 2016 02:50:20 GMT',
                'etag' => '0x8D3A3B5F017F52D',
                'lease_status' => 'unlocked',
                'lease_state' => 'available',
                'content_length' => 4_194_304,
                'content_type' => 'application/octet-stream',
                'content_encoding' => nil,
                'content_language' => nil,
                'content_disposition' => nil,
                'content_md5' => 'tXAohIyxuu/t94Lp/ujeRw==',
                'cache_control' => nil,
                'sequence_number' => 0,
                'blob_type' => 'PageBlob',
                'copy_id' => '095adc3b-e277-4c3d-97e0-0abca881f60c',
                'copy_status' => 'success',
                'copy_source' => 'https://testaccount.blob.core.windows.net/test_container/test_blob?snapshot=2016-02-04T08%3A35%3A50.3256874Z',
                'copy_progress' => '4194304/4194304',
                'copy_completion_time' => 'Thu, 04 Feb 2016 08:35:52 GMT',
                'copy_status_description' => nil,
                'accept_ranges' => 0
              }
            },
            {
              'name' => 'test_blob2',
              'metadata' => {},
              'properties' => {
                'last_modified' => 'Tue, 04 Aug 2015 06:02:08 GMT',
                'etag' => '0x8D29C92173526C8',
                'lease_status' => 'unlocked',
                'lease_state' => 'available',
                'content_length' => 4_194_304,
                'content_type' => 'application/octet-stream',
                'content_encoding' => nil,
                'content_language' => nil,
                'content_disposition' => nil,
                'content_md5' => 'tXAohIyxuu/t94Lp/ujeRw==',
                'cache_control' => nil,
                'sequence_number' => 0,
                'blob_type' => 'PageBlob',
                'copy_id' => '0abcdc3b-4c3d-e277-97e0-0abca881f60c',
                'copy_status' => 'success',
                'copy_source' => 'https://testaccount.blob.core.windows.net/test_container/test_blob?snapshot=2016-02-04T08%3A35%3A55.3157696Z',
                'copy_progress' => '4194304/4194304',
                'copy_completion_time' => 'Thu, 04 Feb 2016 08:40:52 GMT',
                'copy_status_description' => nil,
                'accept_ranges' => 0
              }
            },
            {
              'name' => 'test_blob3',
              'metadata' => {},
              'properties' => {
                'last_modified' => 'Tue, 04 Aug 2015 06:02:08 GMT',
                'etag' => '0x8D29C92173526C8',
                'lease_status' => 'unlocked',
                'lease_state' => 'available',
                'content_length' => 4_194_304,
                'content_type' => 'application/octet-stream',
                'content_encoding' => nil,
                'content_language' => nil,
                'content_disposition' => nil,
                'content_md5' => 'tXAohIyxuu/t94Lp/ujeRw==',
                'cache_control' => nil,
                'sequence_number' => 0,
                'blob_type' => 'PageBlob',
                'copy_id' => '0abcdc3b-4c3d-e277-97e0-0abca881f60c',
                'copy_status' => 'success',
                'copy_source' => 'https://testaccount.blob.core.windows.net/test_container/test_blob?snapshot=2016-02-04T08%3A35%3A55.3157696Z',
                'copy_progress' => '4194304/4194304',
                'copy_completion_time' => 'Thu, 04 Feb 2016 08:40:52 GMT',
                'copy_status_description' => nil,
                'accept_ranges' => 0
              }
            },
            {
              'name' => 'test_blob4',
              'metadata' => {},
              'properties' => {
                'last_modified' => 'Tue, 04 Aug 2015 06:02:08 GMT',
                'etag' => '0x8D29C92173526C8',
                'lease_status' => 'unlocked',
                'lease_state' => 'available',
                'content_length' => 4_194_304,
                'content_type' => 'application/octet-stream',
                'content_encoding' => nil,
                'content_language' => nil,
                'content_disposition' => nil,
                'content_md5' => 'tXAohIyxuu/t94Lp/ujeRw==',
                'cache_control' => nil,
                'sequence_number' => 0,
                'blob_type' => 'PageBlob',
                'copy_id' => '0abcdc3b-4c3d-e277-97e0-0abca881f60c',
                'copy_status' => 'success',
                'copy_source' => 'https://testaccount.blob.core.windows.net/test_container/test_blob?snapshot=2016-02-04T08%3A35%3A55.3157696Z',
                'copy_progress' => '4194304/4194304',
                'copy_completion_time' => 'Thu, 04 Feb 2016 08:40:52 GMT',
                'copy_status_description' => nil,
                'accept_ranges' => 0
              }
            }
          ]
        end
      end
    end
  end
end
