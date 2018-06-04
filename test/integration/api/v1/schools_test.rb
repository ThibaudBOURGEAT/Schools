require 'test_helper'

  feature "Schools" do
    describe "#index" do

      it "returns 401 when token is not authenticated" do
        get api_v1_schools_path
        assert_equal 401, last_response.status
      end


      it "returns 401 when token is unknow" do
        get api_v1_schools_path, nil, {'HTTP_AUTHORIZATION' => '12345AZERTY'}
        assert_equal 401, last_response.status
      end


      it "returns all schools" do
        get api_v1_schools_path, nil, {'HTTP_AUTHORIZATION' => 'valid_token'}
        assert_equal 200, last_response.status
        assert_equal 2, json_response["schools"].length
        assert_equal "first school", json_response['schools'].first['name']
      end

      it "returns public school" do
        get api_v1_schools_path, {status: "Public"}, {'HTTP_AUTHORIZATION' => 'valid_token'}
        assert_equal 200, last_response.status
        assert_equal 1, json_response["schools"].length
        assert_equal "first school", json_response['schools'].first['name']
      end

      it "returns private school" do
        get api_v1_schools_path, {status: "Private"}, {'HTTP_AUTHORIZATION' => 'valid_token'}
        assert_equal 200, last_response.status
        assert_equal 1, json_response["schools"].length
        assert_equal "second school", json_response['schools'].first['name']
      end
    end

    describe "#create" do
      it "returns 201 when school is successfully created" do
        assert_difference "School.all.count"do
          post api_v1_schools_path, {school: {
            name:"new school",
            email:"email@test.com"
            }},
            {'HTTP_AUTHORIZATION' => 'valid_token'}
            assert_equal 201, last_response.status
            assert_equal "new school", json_response['school']['name']
        end
      end

      it "doesn't create a new school when no name given" do
        assert_no_difference "School.all.count"do
          post api_v1_schools_path, {school: {
            name:""
            }},
            {'HTTP_AUTHORIZATION' => 'valid_token'}
            assert_equal 422, last_response.status
        end
      end
    end

    describe"#show" do
      it "returns a school by an id" do
        get api_v1_school_path(2), nil,
          {'HTTP_AUTHORIZATION' => 'valid_token'}
          assert_equal 200, last_response.status
          assert_equal "second school", json_response['school']['name']
      end
    end

    describe"#destroy"do
      it "when delete a school" do
        assert_difference "School.all.count", -1 do
          delete api_v1_school_path(2), nil,
          {'HTTP_AUTHORIZATION' => 'valid_token'}
          assert_equal 200, last_response.status
        end
      end
    end

    describe"#update" do
      it"update school" do
          put api_v1_school_path(1), {school: {
            name: "Louis Querbes",
            }},
            {'HTTP_AUTHORIZATION' => 'valid_token'}
            assert_equal 200, last_response.status
            assert_equal "Louis Querbes", json_response['school']['name']
      end

      it"doesn't update school" do
          put api_v1_school_path(1), {school: {
            name: ""
            }},
            {'HTTP_AUTHORIZATION' => 'valid_token'}
            assert_equal 422, last_response.status
      end
    end



end
