public interface IMessage
{
    Map<String, String> invoke(List<Map<String, String>> requests);
}