module Fog
  module AzureRM
    class Network
      # Vpn Client Revoked Certificate model class for Network Service
      class VpnClientRevokedCertificate < Fog::Model
        attribute :name
        attribute :id
        attribute :thumbprint
        attribute :provisioning_state

        def self.parse(revoked_cert)
          hash = {}
          hash['name'] = revoked_cert.name
          hash['id'] = revoked_cert.id
          hash['thumbprint'] = revoked_cert.thumbprint
          hash['provisioning_state'] = revoked_cert.provisioning_state
          hash
        end
      end
    end
  end
end
