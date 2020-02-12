package dto.response;

import java.util.List;

public class ErrorMessagesDto {

    public List<String> errormessage;

    public ErrorMessagesDto(List<String> messages) {
        errormessage = messages;
    }
}
