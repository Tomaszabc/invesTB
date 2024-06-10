class NoAttachmentsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.embeds.any? { |embed| embed.attachable.is_a?(ActiveStorage::Blob) }
      record.errors.add(attribute, "Chwilowo nie można dodawać załączników")
    end
  end
end
