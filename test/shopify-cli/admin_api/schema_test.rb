require 'test_helper'

module ShopifyCli
  class AdminAPI
    class SchemaTest < MiniTest::Test
      include TestHelpers::Project
      include TestHelpers::Constants

      def setup
        @test_obj = AdminAPI::Schema[JSON.parse(File.read(File.join(ShopifyCli::ROOT, "test/fixtures/shopify_schema.json")))]
        @enum = {
          "kind" => "ENUM",
          "name" => "WebhookSubscriptionTopic",
          "enumValues" => [{ "name" => "APP_UNINSTALLED" }],
        }
      end

      def test_gets_schema
        Helpers::Store.expects(:exists?).returns(false)
        Helpers::Store.expects(:set).with(shopify_admin_schema: "{\"foo\":\"baz\"}")
        Helpers::Store.expects(:get).with(:shopify_admin_schema).returns("{\"foo\":\"baz\"}")
        ShopifyCli::AdminAPI.expects(:query)
          .with(@context, 'admin_introspection')
          .returns(foo: "baz")
        assert_equal({ "foo" => "baz" }, AdminAPI::Schema.get(@context))
      end

      def test_gets_schema_if_already_downloaded
        Helpers::Store.expects(:exists?).returns(true)
        Helpers::Store.expects(:get).with(:shopify_admin_schema).returns("{\"foo\":\"baz\"}")
        assert_equal({ "foo" => "baz" }, AdminAPI::Schema.get(@context))
      end

      def test_access
        assert_equal(@test_obj.type('WebhookSubscriptionTopic'), @enum)
      end

      def test_get_names_from_enum
        assert_equal(@test_obj.get_names_from_type('WebhookSubscriptionTopic'), ["APP_UNINSTALLED"])
      end
    end
  end
end